import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// حالة فارغة/خطأ موحّدة مع زر إعادة المحاولة الاختياري
class StatePlaceholder extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback? onRetry;
  final String? actionLabel;

  const StatePlaceholder({
    super.key,
    required this.icon,
    required this.message,
    this.onRetry,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lgPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56.w, color: AppColors.primary),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style:
                  AppFonts.tajawalMedium16.copyWith(color: AppColors.textGray),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: onRetry,
                child: Text(actionLabel ?? AppStrings.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
