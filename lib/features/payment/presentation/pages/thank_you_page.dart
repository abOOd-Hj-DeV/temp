import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// بيانات شاشة «شكراً لك» بعد الجلسة الأولية
/// لا يوفّر الباك‑إند endpoint لملخص المعالج، فتُمرَّر القيم عند التوجيه
class ThankYouArgs {
  final String therapistSummary;
  final String initialAssessment;
  final String programName;
  final List<String> programFeatures;

  const ThankYouArgs({
    required this.therapistSummary,
    required this.initialAssessment,
    required this.programName,
    required this.programFeatures,
  });

  static const sample = ThankYouArgs(
    therapistSummary:
        'بناءً على الجلسة، لاحظت أن لديك بعض أعراض القلق والتوتر المرتبطة بضغوط العمل. أوصي بالبدء ببرنامج علاجي معرفي سلوكي لمدة 8 أسابيع.',
    initialAssessment: 'PHQ: 14, GAD: 12 - قلق متوسط إلى شديد',
    programName: 'برنامج العلاج المعرفي السلوكي',
    programFeatures: [
      '16 جلسة على مدى 8 أسابيع',
      'وحدات تعليمية تفاعلية',
      'تمارين يومية ومتابعة مستمرة',
      'دعم عبر المراسلة (رد خلال 8 ساعات عمل)',
    ],
  );
}

class ThankYouPage extends StatelessWidget {
  final ThankYouArgs args;

  const ThankYouPage({super.key, this.args = ThankYouArgs.sample});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
              AppSizes.lgPadding.w, 32.h, AppSizes.lgPadding.w, 24.h),
          children: [
            Center(
              child: Container(
                width: 96.w,
                height: 96.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(Icons.check_circle_outline_rounded,
                    size: 56.w, color: AppColors.white),
              ),
            ),
            SizedBox(height: 20.h),
            Text(AppStrings.thankYou,
                textAlign: TextAlign.center,
                style:
                    AppFonts.tajawalBold24.copyWith(color: AppColors.textBlack)),
            SizedBox(height: 4.h),
            Text(AppStrings.initialSessionDone,
                textAlign: TextAlign.center,
                style: AppFonts.tajawalRegular14
                    .copyWith(color: AppColors.textGray)),
            SizedBox(height: 24.h),
            CustomCard(
              margin: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(AppSizes.lgRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.description_outlined,
                          size: 20, color: AppColors.primary),
                      SizedBox(width: 6.w),
                      Text(AppStrings.therapistSummary,
                          style: AppFonts.tajawalBold16
                              .copyWith(color: AppColors.textBlack)),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(args.therapistSummary,
                      style: AppFonts.tajawalRegular14.copyWith(
                          color: AppColors.textGray36, height: 1.7)),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSizes.mdPadding),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(AppSizes.slRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.initialAssessmentLabel,
                            style: AppFonts.tajawalBold14
                                .copyWith(color: AppColors.primary)),
                        SizedBox(height: 4.h),
                        Text(args.initialAssessment,
                            style: AppFonts.tajawalRegular14
                                .copyWith(color: AppColors.textGray36)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _SuggestedProgramCard(args: args),
            SizedBox(height: 16.h),
            CustomButton(
              text: AppStrings.thinkLater,
              onPressed: () => Modular.to.navigate(AppRouteName.home),
              color: AppColors.white,
              textColor: AppColors.textBlack,
              borderColor: AppColors.grayE6,
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestedProgramCard extends StatelessWidget {
  final ThankYouArgs args;
  const _SuggestedProgramCard({required this.args});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lgPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primary, Color(0xFF3FA9B5)],
        ),
        borderRadius: BorderRadius.circular(AppSizes.lgRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 20, color: AppColors.white),
              SizedBox(width: 6.w),
              Text(AppStrings.suggestedProgram,
                  style:
                      AppFonts.tajawalBold16.copyWith(color: AppColors.white)),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.lgPadding),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSizes.slRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(args.programName,
                    style: AppFonts.tajawalMedium16
                        .copyWith(color: AppColors.white)),
                SizedBox(height: 10.h),
                for (final f in args.programFeatures)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline,
                            size: 16, color: AppColors.white),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(f,
                              style: AppFonts.tajawalRegular14
                                  .copyWith(color: AppColors.white)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          CustomButton(
            text: AppStrings.messageTherapist,
            onPressed: () => Modular.to.pushNamed(AppRouteName.helpAndSupport),
            color: AppColors.white,
            textColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
