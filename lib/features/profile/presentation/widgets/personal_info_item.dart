import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class PersonalInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool showEditIcon;
  final VoidCallback? onEdit;

  const PersonalInfoItem({
    super.key,
    required this.label,
    required this.value,
    this.showEditIcon = true,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.mdPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (showEditIcon)
            GestureDetector(
              onTap: onEdit,
              child: const Icon(
                Iconsax.edit,
                size: 20,
                color: AppColors.textGray9A,
              ),
            )
          else
            const SizedBox.shrink(),
          if (showEditIcon) SizedBox(width: 10.w),
          Text(
            label,
            style: AppFonts.tajawalMedium16.copyWith(
              color: AppColors.black12,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: AppFonts.plusJakartaSansRegular14,
            ),
          ),
        ],
      ),
    );
  }
}
