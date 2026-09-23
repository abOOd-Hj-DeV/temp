import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class TherapistLisDoctorCard extends StatelessWidget {
  final TherapistModel doctorModel;
  final void Function()? onViwe;
  final void Function()? onAppointment;
  final bool? isLoading;
  const TherapistLisDoctorCard({
    super.key,
    required this.doctorModel,
    required this.onViwe,
    required this.onAppointment,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      isLoding: isLoading,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDoctorInfo(),
          SizedBox(height: AppSizes.lgPadding.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildAvatar(),
            SizedBox(width: AppSizes.mdPadding.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorModel.name,
                  style: AppFonts.tajawalBold16.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
                Text(
                  doctorModel.title ,
                  style: AppFonts.tajawalMedium14.copyWith(
                    color: AppColors.textGray,
                  ),
                ),
                _buildRatingAndExperience(),
                SizedBox(height: AppSizes.xsPadding.h),
                _buildLocation(),
              ],
            ),
            const Spacer(),
            _buildAvailabilityBadge(),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyF6,
        borderRadius: BorderRadius.circular(AppSizes.mdRadius),
      ),
      child: doctorModel.imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.mdRadius),
              child: Image.network(
                doctorModel.imageUrl!,
                width: 60.w,
                height: 60.w,
                fit: BoxFit.cover,
              ),
            )
          : Icon(
              Icons.person,
              color: AppColors.textGray99,
              size: 40.w,
            ),
    );
  }

  Widget _buildRatingAndExperience() {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.yellow,
          size: 18.w,
        ),
        SizedBox(width: 4.w),
        Text(
          doctorModel.rating.toString(),
          style: AppFonts.tajawalMedium12.copyWith(
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '(${doctorModel.reviewCount})',
          style: AppFonts.tajawalMedium12.copyWith(
            color: AppColors.textGray500,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          ' ${doctorModel.experienceYears} سنوات خبرة',
          style: AppFonts.tajawalMedium12.copyWith(
            color: AppColors.textGray500,
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(
          Iconsax.location,
          color: AppColors.textGray500,
          size: 16.w,
        ),
        SizedBox(width: 4.w),
        Text(
          doctorModel.country,
          style: AppFonts.tajawalMedium14.copyWith(
            color: AppColors.greyAA,
          ),
        ),
        ...List.generate(
          doctorModel.languages.length,
          (index) => Text(
            ' ${doctorModel.languages[index]}',
            style: AppFonts.tajawalMedium14.copyWith(
              color: AppColors.greyAA,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAvailabilityBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mdPadding.w,
        vertical: AppSizes.xsPadding.h,
      ),
      decoration: BoxDecoration(
        color: doctorModel.isAvailable ? AppColors.mintGreen : AppColors.greyF6,
        borderRadius: BorderRadius.circular(AppSizes.xxlRadius),
      ),
      child: Text(
        doctorModel.isAvailable ? AppStrings.available : AppStrings.unavailable,
        style: AppFonts.tajawalMedium12.copyWith(
          color: doctorModel.isAvailable
              ? AppColors.primary
              : AppColors.textGray500,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onViwe,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppColors.textGray99.withValues(alpha: 0.3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.slRadius),
              ),
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mdPadding.h,
              ),
            ),
            child: Text(
              AppStrings.viewDetails,
              style: AppFonts.tajawalMedium14.copyWith(
                color: AppColors.black0A,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.mdPadding.w),
        Expanded(
          child: ElevatedButton(
            onPressed: onAppointment,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.slRadius),
              ),
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mdPadding.h,
              ),
              elevation: 0,
            ),
            child: Text(
              AppStrings.bookFirstSession,
              style: AppFonts.tajawalMedium14.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
