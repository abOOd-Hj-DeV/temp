import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// شاشة الطوارئ (مطابقة لـ Figma) — الأرقام ثابتة محلياً لعدم وجود endpoint لها
class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  static const _hotline = '920-033-360';
  static const _whatsapp = '+966-50-XXX-XXXX';

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (context.mounted) {
      AlertService.showSuccess(context, message: '${AppStrings.copied}: $value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.minRed,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 56.h, bottom: 16.h),
                  children: [
                    Center(
                      child: Container(
                        width: 96.w,
                        height: 96.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.red,
                        ),
                        child: Icon(Icons.warning_amber_rounded,
                            size: 52.w, color: AppColors.white),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(AppStrings.emergency,
                        textAlign: TextAlign.center,
                        style: AppFonts.tajawalBold24
                            .copyWith(color: AppColors.textBlack)),
                    SizedBox(height: 24.h),
                    CustomCard(
                      margin: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(AppSizes.lgRadius),
                      child: Column(
                        children: [
                          Text(AppStrings.emergencyIntro,
                              textAlign: TextAlign.center,
                              style: AppFonts.tajawalRegular14.copyWith(
                                  color: AppColors.textBlackF1, height: 1.7)),
                          SizedBox(height: 8.h),
                          Text(AppStrings.emergencyLocalNotice,
                              textAlign: TextAlign.center,
                              style: AppFonts.tajawalMedium14.copyWith(
                                  color: AppColors.red, height: 1.7)),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _ContactCard(
                      icon: Icons.phone_outlined,
                      iconColor: AppColors.red,
                      title: AppStrings.mentalHealthHotline,
                      value: _hotline,
                      onTap: () => _copy(context, _hotline),
                    ),
                    SizedBox(height: 12.h),
                    _ContactCard(
                      icon: Icons.chat_bubble_outline_rounded,
                      iconColor: const Color(0xFF25D366),
                      title: AppStrings.whatsappSupport,
                      value: _whatsapp,
                      onTap: () => _copy(context, _whatsapp),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: AppStrings.talkToClinician,
                    onPressed: () => _copy(context, _hotline),
                    color: AppColors.red,
                    textColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(AppSizes.lgRadius),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppFonts.tajawalMedium14
                          .copyWith(color: AppColors.textBlackF1)),
                  SizedBox(height: 4.h),
                  Text(value,
                      textDirection: TextDirection.ltr,
                      style: AppFonts.tajawalMedium14.copyWith(color: iconColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
