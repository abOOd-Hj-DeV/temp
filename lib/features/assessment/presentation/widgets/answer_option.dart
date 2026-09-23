import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  const AnswerOption({
    super.key,
    required this.text,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: EdgeInsets.only(bottom: 12.h),
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.mdRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grayE6,
            width: 1.2,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppFonts.tajawalMedium16.copyWith(
            color: isSelected ? AppColors.white : AppColors.textBlackF1,
          ),
        ),
      ),
    );
  }
}
