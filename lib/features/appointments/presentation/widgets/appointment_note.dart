import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class AppointmentNote extends StatelessWidget {
  final String note;

  const AppointmentNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      note,
      style: AppFonts.tajawalRegular12.copyWith(
        color: AppColors.textGray,
        height: 1.6,
      ),
    );
  }
}
