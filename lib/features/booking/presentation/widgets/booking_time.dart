import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/booking/presentation/blocs/booking_bloc.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class BookingTime extends StatelessWidget {
  const BookingTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state.status == BookingStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
        if (state.status == BookingStatus.failure) {
          return Center(child: Text(state.error ?? ''));
        }
        if (state.times.isEmpty) {
          return const Center(child: Text(AppStrings.noAvailableTimes));
        }
        return _buildLodedState(state, context);
      },
    );
  }
}

Widget _buildLodedState(BookingState state, BuildContext context) {
  return Column(
    children: [
      _buildTitleAndIcon(
        text: AppStrings.selectTime,
        icon: Iconsax.clock,
      ),
      Expanded(
        child: GridView.builder(
          itemCount: state.times.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppSizes.smPadding,
            mainAxisSpacing: AppSizes.smPadding,
            childAspectRatio: 1.8,
          ),
          itemBuilder: (context, index) => _buildTimeCard(
            onTap: () {
              context
                  .read<BookingBloc>()
                  .add(BookingTimeSelected(state.times[index]));
            },
            time: state.times[index].time,
          ),
        ),
      ),
    ],
  );
}

Widget _buildTimeCard({
  void Function()? onTap,
  required String time,
}) {
  return InkWell(
    onTap: onTap,
    child: CustomCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      border: Border.all(
        width: 1,
        color: AppColors.greyDB,
      ),
      child: Center(
        child: Text(
          time,
          style: AppFonts.tajawalMedium16.copyWith(color: AppColors.textGray),
        ),
      ),
    ),
  );
}

Widget _buildTitleAndIcon({
  required String text,
  IconData? icon,
}) {
  return Row(
    spacing: AppSizes.smPadding,
    children: [
      Icon(icon),
      Text(
        text,
        style: AppFonts.tajawalMedium16.copyWith(color: AppColors.black10),
      ),
    ],
  );
}
