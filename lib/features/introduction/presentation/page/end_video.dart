import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndVideoPage extends StatelessWidget {
  const EndVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Align(
        alignment: Alignment.center,
        child: CustomCard(
          backgroundColor: AppColors.white,
          margin: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
          width: double.infinity,
          padding: EdgeInsets.all(AppSizes.xlPadding.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildVideoIcon(),
              SizedBox(height: 16.h),
              Text(
                AppStrings.importantDetails,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                AppStrings.endVideoDescription,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGray,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: AppStrings.playVideo,
                  onPressed: () {
                    Modular.to.pushReplacementNamed(AppRouteName.welcome);
                  },
                  color: AppColors.primary,
                  textColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoIcon() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: const BoxDecoration(
        color: AppColors.greyF6,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.videocam,
        size: 40.w,
        color: AppColors.textBlack,
      ),
    );
  }
}
