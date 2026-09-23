import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileInfoHeader extends StatelessWidget implements PreferredSizeWidget {
  const ProfileInfoHeader({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: const EdgeInsets.only(right: AppSizes.lgPadding),
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Modular.to.pop(),
            icon: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(AppSizes.lgPadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.smRadius),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 12,
                color: AppColors.textGray,
              ),
            ),
          ),
          const Spacer(flex: 2),
          Text(
            AppStrings.personalInfo,
            style: AppFonts.tajawalBold16,
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
