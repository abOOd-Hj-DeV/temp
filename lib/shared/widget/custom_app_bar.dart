import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/shared/widget/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.lgPadding,
      ),
      automaticallyImplyLeading: false,
      actions: [
        const CustomBackButton(),
        SizedBox(width: 16.w),
        Text(
          title,
          style: AppFonts.tajawalBold24.copyWith(
            color: AppColors.textBlack,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
