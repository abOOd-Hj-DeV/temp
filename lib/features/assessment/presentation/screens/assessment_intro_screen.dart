import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssessmentIntroScreen extends StatelessWidget {
  const AssessmentIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIconCircle(),
                    SizedBox(height: 32.h),
                    _buildTitle(),
                    SizedBox(height: 16.h),
                    _buildDescription(),
                    SizedBox(height: 32.h),
                    _buildDurationBadge(),
                  ],
                ),
              ),
              _buildStartButton(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconCircle() {
    return Container(
      width: 160.w,
      height: 160.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(0.15),
      ),
      child: Center(
        child: Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary,
              width: 3.w,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.info_outline_rounded,
              size: 48.w,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppStrings.assessmentIntroTitle,
      style: AppFonts.tajawalBold24.copyWith(
        color: AppColors.textBlack,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Text(
      AppStrings.assessmentIntroDescription,
      style: AppFonts.tajawalMedium16.copyWith(
        color: AppColors.greyAA,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDurationBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.xlRadius),
      ),
      child: Text(
        AppStrings.assessmentDuration,
        style: AppFonts.tajawalBold16.copyWith(
          color: AppColors.primary,
          fontSize: 15.sp,
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: AppStrings.startAssessment,
        onPressed: () {
          Modular.to
              .pushReplacementNamed(AppRouteName.assessmentQuestionScreen);
        },
        color: AppColors.primary,
        textColor: AppColors.white,
      ),
    );
  }
}
