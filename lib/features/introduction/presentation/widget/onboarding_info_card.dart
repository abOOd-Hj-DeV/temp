import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/introduction/data/model/onboarding_model.dart';
import 'package:etmaen/features/introduction/presentation/widget/stepper.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingInfoCard extends StatelessWidget {
  final int currentIndex;
  final int totalLength;
  final OnboardingModel currentData;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingInfoCard({
    required this.currentIndex,
    required this.totalLength,
    required this.currentData,
    required this.onNext,
    required this.onSkip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.xxlPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.xxxlRadius),
          topRight: Radius.circular(AppSizes.xxxlRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingStepper(
            index: currentIndex,
            length: totalLength,
          ),
          SizedBox(height: 16.h),
          Text(
            currentData.title,
            style: AppFonts.tajawalBold24,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 2.h),
          Text(
            currentData.description,
            style: AppFonts.tajawalRegular16,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 10,
                child: CustomButton(
                  text: AppStrings.next,
                  onPressed: onNext,
                  color: AppColors.primary,
                  textColor: AppColors.white,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 10,
                child: CustomButton(
                  text: AppStrings.skipVideo,
                  onPressed: onSkip,
                  color: AppColors.white,
                  textColor: AppColors.textBlack,
                  borderColor: AppColors.textBlack,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
