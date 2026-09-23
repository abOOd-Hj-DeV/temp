import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.tajawalBold24.copyWith(
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          subtitle,
          style: AppFonts.tajawalMedium16.copyWith(
            color: AppColors.greyAA,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
