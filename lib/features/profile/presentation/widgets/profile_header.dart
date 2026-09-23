import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 🏔️ الجزء العلوي من صفحة الملف الشخصي (AppBar)
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(AppStrings.profile),
      titleTextStyle: AppFonts.tajawalBold18.copyWith(color: AppColors.white),
      expandedHeight: 140.h,
      automaticallyImplyLeading: false,
      flexibleSpace: const FlexibleSpaceBar(
          background: Padding(
        padding: EdgeInsets.all(AppSizes.lgPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            ProfileInfoCard(
              imageUrl:
                  "https://static.boredpanda.com/blog/wp-content/uploads/2017/03/mr-bean-rowan-atkinson-photoshop-58d8c45e6882a__880.jpg",
              name: 'مستر بين',
              email: 'bean@example.com',
            ),
          ],
        ),
      )),
    );
  }
}
