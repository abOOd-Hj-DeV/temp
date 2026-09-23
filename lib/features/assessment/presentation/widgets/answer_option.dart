import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.mdRadius),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1.6,
          ),
        ),
        child: Text(
          text,
          style: AppFonts.tajawalRegular16.copyWith(
            color: AppColors.black0A,
          ),
        ),
      ),
    );
  }
}
