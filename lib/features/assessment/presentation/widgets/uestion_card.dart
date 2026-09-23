import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionCard extends StatelessWidget {
  final String question;

  const QuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.lgRadius),
      ),
      child: Text(
        question,
        textAlign: TextAlign.center,
        style: AppFonts.tajawalMedium16.copyWith(
          color: AppColors.white,
          height: 1.6,
        ),
      ),
    );
  }
}
