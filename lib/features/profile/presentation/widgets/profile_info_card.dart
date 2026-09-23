import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

/// 💳 بطاقة معلومات المستخدم (الاسم، البريد، الصورة)
class ProfileInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;

  const ProfileInfoCard({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderRadius: BorderRadius.circular(AppSizes.slRadius),
      padding: const EdgeInsets.all(AppSizes.mdPadding),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          // 🖼️ صورة الملف الشخصي مع أيقونة التعديل
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1.2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 25.h,
                  backgroundColor: AppColors.greyF6,
                  backgroundImage:
                      imageUrl != null ? NetworkImage(imageUrl!) : null,
                  child: imageUrl == null
                      ? Icon(
                          Iconsax.user,
                          color: AppColors.primary,
                          size: 30.sp,
                        )
                      : null,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.xsPadding),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.edit_2,
                    size: 14.sp,
                    color: AppColors.textGray500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10.w),

          // 📝 الاسم والبريد الإلكتروني
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppFonts.tajawalMedium16.copyWith(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  email,
                  style: AppFonts.tajawalRegular16.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
