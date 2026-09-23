import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CommitmentAlertBox extends StatelessWidget {
  const CommitmentAlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.all(AppSizes.lgPadding),
      backgroundColor: AppColors.mintGreen,
      border: Border.all(
        color: AppColors.primary,
        width: 0.6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 5.w,
            children: [
              Icon(
                Iconsax.warning_2,
                color: AppColors.primary,
                size: 24.w,
              ),
              Text(
                AppStrings.homeWarning,
                style: AppFonts.tajawalMedium16
                    .copyWith(color: AppColors.textBlack),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.smPadding),
          Text(
            AppStrings.commitmentWarning,
            style:
                AppFonts.tajawalRegular14.copyWith(color: AppColors.textGray),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
