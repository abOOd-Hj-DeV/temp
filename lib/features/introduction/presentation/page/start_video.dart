import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartVideo extends StatelessWidget {
  const StartVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Column(
              children: [
                SizedBox(height: 24.h),
                _buildVideoPlayer(),
                SizedBox(height: 16.h),
                _buildInfoSection(),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.lgPadding.w,
              ),
              child: Column(
                children: [
                    SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: AppStrings.playVideo,
                      onPressed: () {},
                      color: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: AppStrings.skipVideo,
                      onPressed: () {
                        Modular.to.pushReplacementNamed(
                            AppRouteName.assessmentIntroScreen);
                      },
                      color: AppColors.white,
                      textColor: AppColors.textBlack,
                      borderColor: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      height: 220.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
      decoration: BoxDecoration(
        color: AppColors.greyAA,
        borderRadius: BorderRadius.circular(AppSizes.smRadius),
      ),
      child: Center(
        child: Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary,
              width: 3,
            ),
          ),
          child: Icon(
            Icons.play_arrow_rounded,
            color: AppColors.primary,
            size: 36.w,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
      padding: EdgeInsets.all(AppSizes.lgPadding.w),
      decoration: BoxDecoration(
        color: AppColors.mintGreen,
        borderRadius: BorderRadius.circular(AppSizes.smRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.importantDetails,
            style: AppFonts.tajawalBold14.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.startVideoDescription,
            style: AppFonts.tajawalRegular14
                .copyWith(color: AppColors.textBlackF1),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
