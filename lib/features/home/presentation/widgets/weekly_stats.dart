import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/patient/data/models/progress_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeeklyStats extends StatelessWidget {
  final ProgressModel? progress;

  const WeeklyStats({super.key, this.progress});

  @override
  Widget build(BuildContext context) {
    final recent = progress?.recentScores ?? const [];
    final first = recent.isNotEmpty ? recent.first.score : null;
    final last = recent.isNotEmpty ? recent.last.score : null;
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.progressTitle, style: AppFonts.tajawalBold16),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeeklyStatsItem(
                value: '${progress?.assessmentCount ?? 0}',
                label: AppStrings.assessmentsCount,
                isCompleted: true,
              ),
              _dot(),
              WeeklyStatsItem(
                value: progress?.currentScore?.toString() ?? '-',
                label: AppStrings.currentScore,
                isCompleted: false,
              ),
              _dot(),
              WeeklyStatsItem(
                value: (first != null && last != null)
                    ? '${last - first >= 0 ? '+' : ''}${last - first}'
                    : '-',
                label: AppStrings.scoreChange,
                isCompleted: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot() => Container(
        width: 8.w,
        height: 8.h,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
      );
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
