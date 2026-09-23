import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class AppointmentDateLabel extends StatelessWidget {
  final String label;

  const AppointmentDateLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppFonts.tajawalMedium16.copyWith(
        color: AppColors.textGray500,
      ),
    );
  }
}
