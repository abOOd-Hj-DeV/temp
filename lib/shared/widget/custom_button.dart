import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// زر مخصص للتطبيق
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color? borderColor;
  final bool isLoading;
  const CustomButton({
    super.key,
    this.isLoading = false,
    this.borderColor,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      height: 48.h,
      color: color,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(AppSizes.mdRadius),
      ),
      onPressed: onPressed,
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.all(AppSizes.smPadding),
              child: Center(
                child: CircularProgressIndicator(
                  color: textColor,
                ),
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.smPadding),
              child: Text(text,
                  style: AppFonts.tajawalBold16.copyWith(color: textColor)),
            ),
    );
  }
}
