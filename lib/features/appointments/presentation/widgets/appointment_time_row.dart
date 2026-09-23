import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AppointmentTimeRow extends StatelessWidget {
  final String timeLabel;
  final int durationMinutes;

  const AppointmentTimeRow({
    super.key,
    required this.timeLabel,
    required this.durationMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Iconsax.clock,
          color: AppColors.primary,
          size: 26.sp,
        ),
        SizedBox(width: 5.w),
        Text(
          timeLabel,
          style: AppFonts.tajawalMedium18.copyWith(
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          '• $durationMinutes ${AppStrings.minute}',
          style: AppFonts.tajawalRegular12.copyWith(
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }
}
