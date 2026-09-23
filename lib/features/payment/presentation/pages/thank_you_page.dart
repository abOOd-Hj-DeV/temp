import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/payment/presentation/models/package_model.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ThankYouPage extends StatelessWidget {
  final PackageModel? package;

  const ThankYouPage({super.key, this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lgPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140.w,
                      height: 140.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.12),
                      ),
                      child: Icon(Iconsax.tick_circle,
                          size: 72.w, color: AppColors.primary),
                    ),
                    SizedBox(height: 24.h),
                    Text(AppStrings.thankYou,
                        style: AppFonts.tajawalBold24
                            .copyWith(color: AppColors.textBlack)),
                    SizedBox(height: 8.h),
                    Text(
                      package == null
                          ? AppStrings.thankYouDescription
                          : '${AppStrings.thankYouDescription}\n${package!.name}',
                      textAlign: TextAlign.center,
                      style: AppFonts.tajawalMedium16
                          .copyWith(color: AppColors.greyAA),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: AppStrings.goHome,
                onPressed: () => Modular.to.navigate(AppRouteName.home),
                color: AppColors.primary,
                textColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
