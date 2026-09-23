import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/therapist/data/models/therapist_availability_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_review_model.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_detail/therapist_detail_bloc.dart';
import 'package:etmaen/features/therapist/presentation/widgets/doctor_appointments_card.dart';
import 'package:etmaen/features/therapist/presentation/widgets/doctor_detail_card.dart';
import 'package:etmaen/features/therapist/presentation/widgets/doctor_hedar.dart';
import 'package:etmaen/features/therapist/presentation/widgets/doctor_info_card.dart';
import 'package:etmaen/features/therapist/presentation/widgets/doctor_review_item.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:etmaen/shared/widget/custom_floatingAction_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class DoctorProfileDetailsPage extends StatelessWidget {
  const DoctorProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFloatingActionButton(
        onPressed: () {
          final state = context.read<TherapistDetailBloc>().state;
          if (state is TherapistDetailLoaded) {
            Modular.to.pushNamed(AppRouteName.bookingPage,
                arguments: state.therapist);
          }
        },
        text: AppStrings.bookFirstSession,
      ),
      body: BlocBuilder<TherapistDetailBloc, TherapistDetailState>(
        builder: (context, state) {
          switch (state) {
            case TherapistDetailError():
              return _errorState(state.message, context);
            case TherapistDetailLoading():
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            case TherapistDetailLoaded():
              return _buildLodedState(
                therapist: state.therapist,
                availability: state.availability,
                reviews: state.reviews,
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

Widget _buildLodedState({
  required TherapistModel therapist,
  required TherapistAvailabilityModel availability,
  required List<TherapistReviewModel> reviews,
}) {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: DoctorDetailsPageHedar(therapist: therapist),
      ),
      SliverToBoxAdapter(
        child: InfoCards(therapist: therapist),
      ),
      SliverToBoxAdapter(
        child: DetaislCard(therapist: therapist),
      ),
      SliverToBoxAdapter(
        child: DoctorAppointments(availability: availability),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppSizes.lgPadding,
              right: AppSizes.lgPadding,
              bottom: AppSizes.lgPadding),
          child: Row(
            spacing: AppSizes.xsPadding,
            children: [
              Text(
                AppStrings.briefOverview,
                style: AppFonts.tajawalBold16.copyWith(height: 0),
              ),
              Text(
                "(${reviews.length})",
                style: AppFonts.tajawalRegular12
                    .copyWith(color: AppColors.textBlack),
              ),
            ],
          ),
        ),
      ),
      SliverList.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) => ReviewItem(review: reviews[index]),
      ),
    ],
  );
}

Widget _errorState(String message, BuildContext context) {
  final therapistId = Modular.args.data;
  return Padding(
    padding: const EdgeInsets.all(AppSizes.lgPadding),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        CustomButton(
          text: AppStrings.retry,
          onPressed: () {
            if (therapistId is String) {
              context
                  .read<TherapistDetailBloc>()
                  .add(TherapistDetailRequested(therapistId));
            }
          },
          color: AppColors.primary,
          textColor: AppColors.white,
        ),
      ],
    ),
  );
}
