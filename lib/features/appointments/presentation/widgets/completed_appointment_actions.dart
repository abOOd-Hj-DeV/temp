import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedAppointmentActions extends StatelessWidget {
  final VoidCallback onTap;

  const CompletedAppointmentActions({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: CustomButton(
        text: AppStrings.sessionReport,
        onPressed: onTap,
        color: AppColors.greyF7,
        textColor: AppColors.textGray36,
      ),
    );
  }
}
