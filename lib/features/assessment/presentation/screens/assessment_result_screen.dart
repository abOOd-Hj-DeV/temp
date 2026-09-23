import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/assessment/data/models/assessment_result_model.dart';
import 'package:etmaen/features/assessment/data/models/assessment_type.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AssessmentResultScreen extends StatelessWidget {
  final AssessmentResultModel result;

  const AssessmentResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final type = AssessmentType.fromApi(result.assessment.type);
    final maxScore = type.questionCount * 3;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lgPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 24.h),
                    Center(
                      child: Container(
                        width: 140.w,
                        height: 140.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.12),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${result.assessment.score}',
                                  style: AppFonts.tajawalBold24.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 36.sp)),
                              Text('/ $maxScore',
                                  style: AppFonts.tajawalRegular14
                                      .copyWith(color: AppColors.textGray)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(type.title,
                        textAlign: TextAlign.center,
                        style: AppFonts.tajawalBold24
                            .copyWith(color: AppColors.textBlack)),
                    SizedBox(height: 8.h),
                    Text(result.interpretation,
                        textAlign: TextAlign.center,
                        style: AppFonts.tajawalMedium16
                            .copyWith(color: AppColors.primary)),
                    if (result.redFlagCreated) ...[
                      SizedBox(height: 16.h),
                      CustomCard(
                        margin: EdgeInsets.zero,
                        backgroundColor:
                            AppColors.error.withValues(alpha: 0.08),
                        border: Border.all(color: AppColors.error),
                        child: Row(
                          children: [
                            const Icon(Iconsax.danger, color: AppColors.error),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(AppStrings.redFlagNotice,
                                  style: AppFonts.tajawalMedium14
                                      .copyWith(color: AppColors.error)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomButton(
                        text: AppStrings.emergency,
                        onPressed: () =>
                            Modular.to.pushNamed(AppRouteName.emergency),
                        color: AppColors.error,
                        textColor: AppColors.white,
                      ),
                    ],
                    if (result.recommendations.isNotEmpty) ...[
                      SizedBox(height: 24.h),
                      Text(AppStrings.recommendations,
                          style: AppFonts.tajawalBold16),
                      SizedBox(height: 8.h),
                      for (final r in result.recommendations)
                        CustomCard(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Iconsax.tick_circle,
                                  color: AppColors.primary),
                              SizedBox(width: 8.w),
                              Expanded(
                                  child: Text(r,
                                      style: AppFonts.tajawalRegular14)),
                            ],
                          ),
                        ),
                    ],
                    SizedBox(height: 16.h),
                    Text(AppStrings.assessmentDisclaimer,
                        textAlign: TextAlign.center,
                        style: AppFonts.tajawalRegular12
                            .copyWith(color: AppColors.textGray)),
                  ],
                ),
              ),
              CustomButton(
                text: AppStrings.browseTherapists,
                onPressed: () =>
                    Modular.to.pushNamed(AppRouteName.availableOptions),
                color: AppColors.primary,
                textColor: AppColors.white,
              ),
              SizedBox(height: 8.h),
              CustomButton(
                text: AppStrings.goHome,
                onPressed: () => Modular.to.navigate(AppRouteName.home),
                color: AppColors.white,
                textColor: AppColors.primary,
                borderColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
