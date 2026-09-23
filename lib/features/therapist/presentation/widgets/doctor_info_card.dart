import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class InfoCards extends StatelessWidget {
  final TherapistModel therapist;
  const InfoCards({
    super.key,
    required this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        AppSizes.lgPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InfoCard(
              icon: Iconsax.medal,
              title: AppStrings.experience,
              description: "${therapist.yearsOfExperience} سنوات",
            ),
          ),
          const SizedBox(width: AppSizes.lgPadding),
          Expanded(
            child: InfoCard(
              icon: Iconsax.location,
              title: AppStrings.countryLabel,
              description: therapist.country,
            ),
          ),
          const SizedBox(width: AppSizes.lgPadding),
          Expanded(
            child: InfoCard(
              icon: Iconsax.language_circle,
              title: AppStrings.languagesLabel,
              description: therapist.languages.join('، '),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: AppColors.primary,
              ),
              SizedBox(
                width: 5.h,
              ),
              Text(
                title,
                style: AppFonts.tajawalRegular14
                    .copyWith(color: AppColors.textGray),
              ),
            ],
          ),
          Text(
            description,
            style: AppFonts.tajawalBold14.copyWith(color: AppColors.primary),
          )
        ],
      ),
    );
  }
}
