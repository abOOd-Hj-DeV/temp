import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';

/// 📂 قسم يجمع مجموعة من عناصر القائمة تحت عنوان معين
class ProfileMenuSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.lgPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.mdPadding),
            child: Text(
              title,
              style: AppFonts.tajawalRegular16.copyWith(
                color: AppColors.textBlackF1,
              ),
            ),
          ),
          CustomCard(
            padding: const EdgeInsets.all(AppSizes.smPadding),
            margin: EdgeInsets.zero,
            child: Column(
              children: items,
            ),
          ),
        ],
      ),
    );
  }
}
