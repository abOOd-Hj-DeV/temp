import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeeklyStats extends StatelessWidget {
  const WeeklyStats({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.weeklyStats,
            style: AppFonts.tajawalBold16,
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const WeeklyStatsItem(
                value: '18/30',
                label: AppStrings.daysRegistered,
                isCompleted: true,
              ),
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const WeeklyStatsItem(
                  value: '12/19',
                  label: AppStrings.exercisesCompleted,
                  isCompleted: false),
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const WeeklyStatsItem(
                  value: '20/20',
                  label: AppStrings.exercisesDone,
                  isCompleted: false),
            ],
          ),
        ],
      ),
    );
  }
}

class WeeklyStatsItem extends StatelessWidget {
  const WeeklyStatsItem(
      {super.key,
      required this.value,
      required this.label,
      required this.isCompleted});
  final String value;
  final String label;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppFonts.tajawalBold18.copyWith(
            color: isCompleted ? AppColors.primary : AppColors.textBlack,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          label,
          style: AppFonts.tajawalRegular14.copyWith(color: AppColors.textGray),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
