import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class DoctorDetailsPageHedar extends StatelessWidget {
  final TherapistModel therapist;
  const DoctorDetailsPageHedar({
    super.key,
    required this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.40.sh,
      child: Stack(
        children: [
          Container(
            height: 0.32.sh,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSizes.lgRadius),
                bottomRight: Radius.circular(AppSizes.lgRadius),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: AppSizes.lgPadding),
                        child: InkWell(
                          onTap: () {
                            Modular.to.pop();
                          },
                          child: Icon(
                            size: 18.sp,
                            Icons.arrow_back_ios_new,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.textGray,
                        backgroundImage: therapist.imageUrl != null
                            ? NetworkImage(therapist.imageUrl!)
                            : null,
                        radius: 38,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        therapist.fullName,
                        style: AppFonts.tajawalBold16.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        therapist.specialty,
                        style: AppFonts.tajawalBold16.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Row(
                        spacing: 5.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_border_rounded,
                            color: Colors.amber,
                          ),
                          Text(
                            therapist.rating.toStringAsFixed(1),
                            style: AppFonts.tajawalRegular18,
                          ),
                          Text(
                            "(${therapist.reviewCount})",
                            style: AppFonts.tajawalRegular12,
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: HedarDescriptionCard(),
          )
        ],
      ),
    );
  }
}

class HedarDescriptionCard extends StatelessWidget {
  const HedarDescriptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderRadius: BorderRadius.circular(AppSizes.lgRadius),
      width: 0.9.sw,
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.smPadding),
      child: Row(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Iconsax.sun_1,
            color: AppColors.primary,
            size: 15.sp,
          ),
          Expanded(
            child: Text(
              AppStrings.promotionalDescription,
              style: AppFonts.tajawalRegular16,
              textAlign: TextAlign.start,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
