import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class _EmergencyContact {
  final String title;
  final String number;
  final String description;
  const _EmergencyContact(this.title, this.number, this.description);
}

/// أرقام الطوارئ — لا يوفر الباك‑إند endpoint لها فهي ثابتة محلياً
class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  static const _contacts = [
    _EmergencyContact(
        'الطوارئ الموحد', '911', 'الشرطة والإسعاف والدفاع المدني'),
    _EmergencyContact('الهلال الأحمر', '997', 'الإسعاف'),
    _EmergencyContact('الدعم النفسي (استشارات)', '920033360',
        'المركز الوطني لتعزيز الصحة النفسية'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.emergency),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.lgPadding),
        children: [
          CustomCard(
            margin: EdgeInsets.zero,
            backgroundColor: AppColors.error.withValues(alpha: 0.08),
            border: Border.all(color: AppColors.error),
            child: Row(
              children: [
                const Icon(Iconsax.danger, color: AppColors.error),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(AppStrings.emergencyNotice,
                      style: AppFonts.tajawalMedium14
                          .copyWith(color: AppColors.error)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          for (final c in _contacts)
            CustomCard(
              margin: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.mdPadding),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.smRadius),
                    ),
                    child: const Icon(Iconsax.call, color: AppColors.primary),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.title, style: AppFonts.tajawalMedium16),
                        Text(c.description,
                            style: AppFonts.tajawalRegular12
                                .copyWith(color: AppColors.textGray)),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: c.number));
                      if (context.mounted) {
                        AlertService.showSuccess(context,
                            message: '${AppStrings.copied}: ${c.number}');
                      }
                    },
                    icon: const Icon(Iconsax.copy, size: 18),
                    label: Text(c.number,
                        style: AppFonts.tajawalBold16
                            .copyWith(color: AppColors.primary)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
