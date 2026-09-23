import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/features/therapist/data/models/therapist_review_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ReviewItem extends StatelessWidget {
  final TherapistReviewModel review;
  const ReviewItem({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.only(
        bottom: AppSizes.lgPadding,
        left: AppSizes.lgPadding,
        right: AppSizes.lgPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSizes.lgPadding,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.user,
                style: AppFonts.tajawalBold16
                    .copyWith(color: AppColors.textGray36),
              ),
              Row(
                spacing: AppSizes.xsPadding,
                children: [
                  ...List.generate(
                    5,
                    (index) => Icon(
                      index < review.rating ? Iconsax.star5 : Iconsax.star,
                      color: Colors.amber,
                      size: 16.sp,
                    ),
                  )
                ],
              )
            ],
          ),
          Text(
            review.comment,
            style: AppFonts.tajawalRegular16,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
