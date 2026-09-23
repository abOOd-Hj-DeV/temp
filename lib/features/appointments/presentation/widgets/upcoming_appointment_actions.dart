import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingAppointmentActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onCancel;

  const UpcomingAppointmentActions({
    super.key,
    required this.onEdit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: CustomButton(
              text: AppStrings.edit,
              onPressed: onEdit,
              color: AppColors.primary,
              textColor: AppColors.white,
            ),
          ),
          const SizedBox(
            width: AppSizes.mdPadding,
          ),
          Expanded(
            flex: 2,
            child: CustomButton(
              text: AppStrings.cancel,
              onPressed: onCancel,
              color: AppColors.minRed,
              textColor: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
