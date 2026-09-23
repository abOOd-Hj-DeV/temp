import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppointmentSessionBadge extends StatelessWidget {
  final int sessionNumber;

  const AppointmentSessionBadge({
    super.key,
    required this.sessionNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.mdPadding,
          vertical: AppSizes.xsPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.mintGreen,
          borderRadius: BorderRadius.circular(AppSizes.lgRadius),
        ),
        child: Text(
          '${AppStrings.session} #$sessionNumber',
          style: AppFonts.tajawalRegular14.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
