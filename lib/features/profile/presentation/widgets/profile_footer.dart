import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 🏁 تذييل الصفحة (رقم النسخة وحقوق النشر)
class ProfileFooter extends StatelessWidget {
  const ProfileFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.all(AppSizes.lgPadding),
      child: Column(
        children: [
          Text(
            "${AppStrings.version} 1.0.0",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textGray,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.copyright,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
