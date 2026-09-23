import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/functions.dart';
import 'package:etmaen/features/booking/presentation/block/booking_cubit.dart';
import 'package:etmaen/features/booking/presentation/block/booking_state.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class BookingDate extends StatelessWidget {
  const BookingDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state.status == BookingStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primary,
          ));
        }
        if (state.status == BookingStatus.failure) {
          return Center(child: Text(state.error ?? ''));
        }
        if (state.dates.isEmpty) {
          return const Center(child: Text(AppStrings.noAvailableDates));
        }
        return _buidLodedState(state);
      },
    );
  }
}

Widget _buidLodedState(BookingState state) {
  return Column(
    children: [
      _buildTitleAndIcon(text: AppStrings.selectDate, icon: Iconsax.calendar_1),
      Expanded(
        child: GridView.builder(
            itemCount: state.dates.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.2,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              final (day, month) =
                  getArabicMonthAndDay(state.dates[index].date);
              return _buildDateCard(
                onTap: () {
                  context.read<BookingCubit>().selectDate(state.dates[index]);
                },
                daye: day,
                month: month,
              );
            }),
      ),
    ],
  );
}

Widget _buildDateCard(
    {required String month, required String daye, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: CustomCard(
      margin: const EdgeInsets.all(AppSizes.xsPadding),
      border: Border.all(
        width: 1,
        color: AppColors.greyDB,
      ),
      child: Column(
        children: [
          Text(
            daye,
            style: AppFonts.tajawalMedium16.copyWith(color: AppColors.textGray),
          ),
          Text(
            month,
            style: AppFonts.tajawalRegular20.copyWith(color: AppColors.black10),
          ),
        ],
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
