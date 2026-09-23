import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_list/therapist_list_cubit.dart';
import 'package:etmaen/features/therapist/presentation/widgets/therapist_lis_doctor_card.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableOptionsPage extends StatelessWidget {
  const AvailableOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<TherapistListCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.lgPadding.w,
          ),
          child: Column(
            spacing: AppSizes.lgPadding.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.availableOptions,
                style: AppFonts.tajawalMedium16.copyWith(
                  color: AppColors.black00,
                ),
              ),
              _buildSearchBar(),
              Expanded(
                child: BlocBuilder<TherapistListCubit, TherapistListState>(
                  builder: (context, state) {
                    switch (state) {
                      case TherapistListError():
                        return Text(state.message);
                      case TherapistListLoading():
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      case TherapistListLoaded():
                        return ListView.builder(
                          itemCount: state.therapists.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: AppSizes.lgPadding.h,
                              ),
                              child: TherapistLisDoctorCard(
                                onAppointment: () {
                                  cubit.navigateToBookingPage(
                                    state.therapists[index],
                                  );
                                },
                                doctorModel: state.therapists[index],
                                onViwe: () {
                                  cubit.getTherapistById(
                                      state.therapists[index].id);
                                },
                              ),
                            );
                          },
                        );
                      default:
                        return const SizedBox(height: 100);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.lgPadding.w,
        vertical: AppSizes.mdPadding.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.mdRadius),
        border: Border.all(
          color: AppColors.textGray99.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.tune,
            color: AppColors.textGray500,
            size: 22.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              AppStrings.searchHint,
              style: AppFonts.tajawalMedium14.copyWith(
                color: AppColors.textGray99,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
