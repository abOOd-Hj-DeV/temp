import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/payment/presentation/models/package_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

/// ملخص الدفع — الدفع الفعلي يتم يدوياً عبر التحويل ورفع الإيصال لاحقاً
class PaymentSummaryPage extends StatelessWidget {
  final PackageModel package;

  const PaymentSummaryPage({super.key, required this.package});

  Widget _row(String label, String value, {bool bold = false}) => Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Text(label,
                style: AppFonts.tajawalRegular14
                    .copyWith(color: AppColors.textGray)),
            const Spacer(),
            Text(value,
                style: bold
                    ? AppFonts.tajawalBold16.copyWith(color: AppColors.primary)
                    : AppFonts.tajawalMedium14),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final vat = (package.price * 0.15).round();
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.paymentSummary),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lgPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomCard(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  _row(AppStrings.package, package.name),
                  _row(AppStrings.sessions, '${package.sessions}'),
                  _row(AppStrings.duration,
                      '${package.durationDays} ${AppStrings.days}'),
                  const Divider(),
                  _row(AppStrings.subtotal,
                      '${package.price} ${AppStrings.currency}'),
                  _row(AppStrings.vat, '$vat ${AppStrings.currency}'),
                  const Divider(),
                  _row(AppStrings.total,
                      '${package.price + vat} ${AppStrings.currency}',
                      bold: true),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            CustomCard(
              margin: EdgeInsets.zero,
              backgroundColor: AppColors.mintGreen,
              child: Row(
                children: [
                  const Icon(Iconsax.info_circle, color: AppColors.primary),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(AppStrings.manualPaymentNotice,
                        style: AppFonts.tajawalRegular14
                            .copyWith(color: AppColors.textBlack)),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              text: AppStrings.confirmSubscription,
              onPressed: () => Modular.to.pushReplacementNamed(
                AppRouteName.thankYou,
                arguments: package,
              ),
              color: AppColors.primary,
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
