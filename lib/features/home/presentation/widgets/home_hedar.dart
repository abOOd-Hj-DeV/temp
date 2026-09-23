import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_button.dart' show CustomButton;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSizes.mdRadius),
            bottomRight: Radius.circular(AppSizes.mdRadius),
          ),
        ),
        pinned: true,
        expandedHeight: 300.h,
        actionsPadding:
            const EdgeInsets.symmetric(horizontal: AppSizes.mdPadding),
        actions: [
          Icon(
            Iconsax.menu_1,
            color: AppColors.white,
            size: 24.sp,
          ),
          const Spacer(),
          Icon(
            Iconsax.notification,
            color: AppColors.white,
            size: 24.sp,
          ),
        ],
        flexibleSpace: const FlexibleSpaceBar(
          background: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              HomeDoctorItem(
                imageUrl:
                    "https://static.boredpanda.com/blog/wp-content/uploads/2017/03/mr-bean-rowan-atkinson-photoshop-58d8c45e6882a__880.jpg",
                name: "د. سارة أحمد",
              ),
              SubscriptionCard(),
            ],
          ),
        ));
  }
}

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: EdgeInsets.all(AppSizes.lgRadius),
      borderRadius: BorderRadius.circular(AppSizes.xlRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(AppStrings.subscription,
                  style: AppFonts.tajawalRegular14
                      .copyWith(color: AppColors.textGray)),
              const Spacer(),
              Text(AppStrings.remaining,
                  style: AppFonts.tajawalRegular12
                      .copyWith(color: AppColors.textGray)),
              Text("42 ${AppStrings.days}",
                  style: AppFonts.tajawalBold16
                      .copyWith(color: AppColors.primary)),
            ],
          ),
          Text(AppStrings.subscriptionPackageLabel,
              style: AppFonts.tajawalBold18),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.programProgress,
                  style: AppFonts.tajawalRegular12
                      .copyWith(color: AppColors.textGray)),
              Text(AppStrings.programProgressFormat,
                  style: AppFonts.tajawalRegular12
                      .copyWith(color: AppColors.textGray)),
            ],
          ),
          SizedBox(height: AppSizes.smPadding.h),
          LinearProgressIndicator(
            minHeight: 8.h,
            color: AppColors.primary,
            value: 0.35,
            backgroundColor: AppColors.mintGreen,
            borderRadius: BorderRadius.circular(AppSizes.pillRadius),
          )
        ],
      ),
    );
  }
}

class HomeDoctorItem extends StatelessWidget {
  const HomeDoctorItem({
    super.key,
    this.imageUrl,
    required this.name,
  });

  final String? imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.lgPadding),
      backgroundColor: Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(AppSizes.mdRadius),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.h,
            backgroundColor: AppColors.greyF6,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            child: imageUrl == null
                ? Icon(
                    Iconsax.user,
                    color: AppColors.primary,
                    size: 30.sp,
                  )
                : null,
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.yourTherapist,
                style: AppFonts.tajawalRegular14,
              ),
              Text(
                "د. سارة أحمد",
                style: AppFonts.tajawalRegular14,
              ),
            ],
          ),
          const Spacer(),
          CustomButton(
              text: AppStrings.message,
              onPressed: () {
                Modular.to.pushNamed(AppRouteName.doctorProfileDetails,
                    arguments: 'y1k1f76qi8xzqob');
              },
              color: AppColors.white,
              textColor: AppColors.primary),
        ],
      ),
    );
  }
}
 