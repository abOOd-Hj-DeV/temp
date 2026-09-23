import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssessmentProgressIndicator extends StatelessWidget {
  final String title;
  final int currentQuestion;
  final int totalQuestions;
  final VoidCallback onBack;

  const AssessmentProgressIndicator({
    super.key,
    required this.title,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentQuestion / totalQuestions;

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 20, color: AppColors.textBlack),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                title,
                style: AppFonts.tajawalBold18
                    .copyWith(color: AppColors.textBlack),
              ),
            ),
            Text(
              '$currentQuestion/$totalQuestions',
              style: AppFonts.tajawalMedium14.copyWith(
                color: AppColors.textGray,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6.h,
            backgroundColor: AppColors.grayE6,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
