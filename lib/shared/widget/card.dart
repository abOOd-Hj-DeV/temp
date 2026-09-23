import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.isLoding,
    this.backgroundColor,
    this.height,
    this.width,
    this.margin,
    this.borderRadius,
    this.border,
    this.padding,
    this.boxShadow,
  });
  final bool? isLoding;
  final Widget child;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: AppSizes.lgPadding),
      padding: padding ?? const EdgeInsets.all(AppSizes.lgPadding),
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor ?? AppColors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.xlRadius),
        boxShadow: boxShadow,
      ),
      child: isLoding ?? false
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            )
          : child,
    );
  }
}
