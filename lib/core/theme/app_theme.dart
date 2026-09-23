import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// AppTheme
/// ThemeData عام ونظيف — لا يحتوي ستايلات خاصة بكل ويدجت
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,

      // نصوص موحدة من ملف text_style
      textTheme: AppTextTheme.light,

      // AppBar موحد
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSizes.mlRadius),
            bottomRight: Radius.circular(AppSizes.mlRadius),
          ),
        ),
        elevation: 0,
        // centerTitle: true,
        titleTextStyle: AppFonts.tajawalBold18.copyWith(color: AppColors.white),
        // iconTheme: const IconThemeData(color: AppColors.textPrimary),
        // foregroundColor: AppColors.textPrimary,
      ),

      // أيقونات عامة
      // iconTheme: const IconThemeData(color: AppColors.textPrimary),

      // خطوط التقسيم
      // dividerColor: AppColors.divider,
    );
  }
}
