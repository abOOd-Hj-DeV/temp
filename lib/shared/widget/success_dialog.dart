import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// نافذة النجاح (دائرة علامة صح + عنوان + وصف + زر) كما في تصميم Figma
class SuccessDialog extends StatelessWidget {
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.black80,
      builder: (_) => SuccessDialog(
        title: title,
        description: description,
        actionLabel: actionLabel,
        onAction: onAction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSizes.lgPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.xxlRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xlPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            _CheckBadge(size: 96.w),
            SizedBox(height: 20.h),
            Text(title,
                style:
                    AppFonts.tajawalBold18.copyWith(color: AppColors.textBlack)),
            SizedBox(height: 8.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppFonts.tajawalRegular14.copyWith(
                color: AppColors.textGray99,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: actionLabel,
                onPressed: onAction,
                color: AppColors.primary,
                textColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckBadge extends StatelessWidget {
  final double size;
  const _CheckBadge({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.4,
      height: size * 1.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (final (dx, dy, len) in const [
            (-0.42, -0.30, 10.0),
            (0.40, -0.36, 8.0),
            (0.46, 0.10, 6.0),
            (-0.46, 0.22, 8.0),
            (0.28, 0.40, 6.0),
            (-0.10, -0.48, 5.0),
          ])
            Align(
              alignment: Alignment(dx * 2, dy * 2),
              child: Transform.rotate(
                angle: dx * 2,
                child: Container(
                  width: len,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            child: Icon(Icons.check_rounded,
                size: size * 0.55, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
