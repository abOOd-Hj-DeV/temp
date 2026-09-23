import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 🎨 Theme مخصص للنصوص
class AppTextTheme {
  AppTextTheme._();

  static TextTheme get light {
    return TextTheme(
      // العناوين الكبيرة H1
      displayLarge: GoogleFonts.notoSansArabic(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        // color: AppColors.textPrimary,
      ),

      // العناوين المتوسطة H2
      headlineMedium: GoogleFonts.tajawal(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        // color: AppColors.textPrimary,
      ),

      // عناوين الصفحات
      titleLarge: GoogleFonts.notoSansArabic(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        // color: AppColors.textPrimary,
      ),

      //  حقول الادخال عناوين
      bodyMedium: GoogleFonts.notoSansArabic(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        // color: AppColors.greyScale70,
      ),

      titleMedium: GoogleFonts.notoSansArabic(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        // color: AppColors.textPrimary,
      ),

      // نسيت كلمه السر
      bodySmall: GoogleFonts.notoSansArabic(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        // color: AppColors.divider,
      ),
      // نصوص الأزرار
      labelLarge: GoogleFonts.tajawal(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        // color: AppColors.white,
      ),
      //hint text field
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        // color: AppColors.greyScale70,
      ),
    );
  }
}
