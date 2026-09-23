import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AppointmentCommunicationRow extends StatelessWidget {
  final String type; // "call" | "chat"
  final String platform; // "zoom" | "whatsapp"

  const AppointmentCommunicationRow({
    super.key,
    required this.type,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          _icon,
          color: AppColors.primary,
          size: 26.sp,
        ),
        SizedBox(width: 5.w),
        Text(
          "${_typeLabel()} ${AppStrings.via}",
          style: AppFonts.tajawalMedium18.copyWith(
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          _platformLabel(),
          style: AppFonts.tajawalRegular12.copyWith(
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  IconData get _icon {
    if (type == 'chat') return Iconsax.message;
    return Iconsax.video;
  }

  String _typeLabel() {
    switch (type) {
      case 'chat':
        return AppStrings.chat;
      case 'call':
      default:
        return AppStrings.call;
    }
  }

  String _platformLabel() {
    switch (platform) {
      case 'whatsapp':
        return AppStrings.whatsapp;
      case 'zoom':
      default:
        return AppStrings.zoom;
    }
  }
}
