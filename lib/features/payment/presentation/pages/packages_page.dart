import 'package:dotted_border/dotted_border.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/payment/presentation/models/package_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_back_button.dart';
import 'package:etmaen/shared/widget/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// شاشة «اختر باقتك» + طريقة الدفع + رفع الإيصال (مطابقة لـ Figma)
/// الباقات ثابتة محلياً حتى يوفّر الباك‑إند endpoint عام لها
class PackagesPage extends StatefulWidget {
  final bool showBackButton;

  const PackagesPage({super.key, this.showBackButton = true});

  @override
  State<PackagesPage> createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  int _selected = 1;

  PackageModel get _package => PackageModel.available[_selected];

  void _onUploadReceipt() {
    SuccessDialog.show(
      context,
      title: AppStrings.receiptReceivedTitle,
      description: AppStrings.receiptReceivedDescription,
      actionLabel: AppStrings.goHome,
      onAction: () => Modular.to.navigate(AppRouteName.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _Header(showBackButton: widget.showBackButton),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  AppSizes.lgPadding.w, 20.h, AppSizes.lgPadding.w, 24.h),
              children: [
                for (final (i, p) in PackageModel.available.indexed)
                  _PackageCard(
                    package: p,
                    selected: i == _selected,
                    onTap: () => setState(() => _selected = i),
                  ),
                SizedBox(height: 8.h),
                Text(AppStrings.paymentMethod,
                    style: AppFonts.tajawalBold16
                        .copyWith(color: AppColors.textBlack)),
                SizedBox(height: 12.h),
                _BankTransferCard(amount: _package.price),
                SizedBox(height: 20.h),
                Text(AppStrings.uploadReceipt,
                    style: AppFonts.tajawalBold16
                        .copyWith(color: AppColors.textBlack)),
                SizedBox(height: 12.h),
                _ReceiptUploadBox(onTap: _onUploadReceipt),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool showBackButton;
  const _Header({required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(AppSizes.lgPadding.w,
          MediaQuery.paddingOf(context).top + 12.h, AppSizes.lgPadding.w, 20.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSizes.mlRadius),
          bottomRight: Radius.circular(AppSizes.mlRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBackButton) ...[
            const CustomBackButton(),
            SizedBox(height: 12.h),
          ],
          Text(AppStrings.choosePackage,
              style: AppFonts.tajawalBold18.copyWith(color: AppColors.white)),
          SizedBox(height: 4.h),
          Text(AppStrings.choosePackageSubtitle,
              style:
                  AppFonts.tajawalRegular14.copyWith(color: AppColors.white)),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final PackageModel package;
  final bool selected;
  final VoidCallback onTap;

  const _PackageCard({
    required this.package,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final highlighted = selected || package.mostPopular;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h, top: package.mostPopular ? 12.h : 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomCard(
              margin: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(AppSizes.lgRadius),
              border: Border.all(
                color: highlighted ? AppColors.primary : Colors.transparent,
                width: 1.5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(package.name,
                            style: AppFonts.tajawalBold16
                                .copyWith(color: AppColors.textBlack)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${package.price} ${AppStrings.currency}',
                            style: AppFonts.tajawalBold18
                                .copyWith(color: AppColors.primary),
                          ),
                          if (package.savings != null)
                            Text(
                              '${AppStrings.savePrefix} ${package.savings} ${AppStrings.currency}',
                              style: AppFonts.tajawalRegular12
                                  .copyWith(color: AppColors.textGray60),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  for (final f in package.features)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        children: [
                          const Icon(Icons.check,
                              size: 18, color: AppColors.primary),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(f,
                                style: AppFonts.tajawalRegular14
                                    .copyWith(color: AppColors.textGray36)),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (package.mostPopular)
              PositionedDirectional(
                top: -12.h,
                start: 16.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSizes.pillRadius),
                  ),
                  child: Text(AppStrings.mostPopular,
                      style: AppFonts.tajawalMedium12
                          .copyWith(color: AppColors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BankTransferCard extends StatelessWidget {
  final int amount;
  const _BankTransferCard({required this.amount});

  @override
  Widget build(BuildContext context) {
    final labelStyle =
        AppFonts.tajawalRegular14.copyWith(color: AppColors.textGray);
    final valueStyle =
        AppFonts.tajawalMedium14.copyWith(color: AppColors.textBlackF1);

    Widget line(String label, String value) => Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Text.rich(TextSpan(children: [
            TextSpan(text: '$label:  ', style: labelStyle),
            TextSpan(text: value, style: valueStyle),
          ])),
        );

    return CustomCard(
      margin: EdgeInsets.zero,
      backgroundColor: AppColors.greyF6,
      borderRadius: BorderRadius.circular(AppSizes.slRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_outlined,
                  size: 18, color: AppColors.textGray),
              SizedBox(width: 6.w),
              Text(AppStrings.bankTransfer, style: valueStyle),
            ],
          ),
          line(AppStrings.bankLabel, AppStrings.bankName),
          line(AppStrings.accountNumberLabel, AppStrings.accountNumber),
          line(AppStrings.amountLabel, '$amount ${AppStrings.currency}'),
        ],
      ),
    );
  }
}

class _ReceiptUploadBox extends StatelessWidget {
  final VoidCallback onTap;
  const _ReceiptUploadBox({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(AppSizes.slRadius),
          dashPattern: const [6, 4],
          strokeWidth: 1.5,
          color: AppColors.grayE6,
          padding: EdgeInsets.symmetric(vertical: 24.h),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Icon(Icons.file_upload_outlined,
                  size: 28, color: AppColors.textGray),
              SizedBox(height: 8.h),
              Text(AppStrings.uploadReceiptHint,
                  style: AppFonts.tajawalRegular14
                      .copyWith(color: AppColors.textGray)),
            ],
          ),
        ),
      ),
    );
  }
}
