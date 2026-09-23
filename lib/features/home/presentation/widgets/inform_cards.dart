import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformCards extends StatelessWidget {
  const InformCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.lgPadding, vertical: AppSizes.lgPadding),
      child: Row(
        children: [
          Expanded(
            child: InformCardItem(
              title: AppStrings.messaging,
              subtitle: AppStrings.responseTimeSubtitle,
              icon: Icons.calendar_today_outlined,
            ),
          ),
          const SizedBox(width: AppSizes.lgPadding),
          Expanded(
            child: InformCardItem(
              title: AppStrings.messaging,
              subtitle: AppStrings.responseTimeSubtitle,
              icon: Icons.calendar_today_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class InformCardItem extends StatelessWidget {
  const InformCardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(AppSizes.mdPadding.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.smRadius),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24.w,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: AppFonts.tajawalMedium16,
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            style:
                AppFonts.tajawalRegular14.copyWith(color: AppColors.textGray),
          ),
        ],
      ),
    );
  }
}
