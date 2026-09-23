import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/patient/data/models/dashboard_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_button.dart' show CustomButton;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class HomeSliverAppBar extends StatelessWidget {
  final DashboardModel? dashboard;

  const HomeSliverAppBar({super.key, this.dashboard});

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
        IconButton(
          onPressed: () => Modular.to.pushNamed(AppRouteName.emergency),
          icon: Icon(Iconsax.danger, color: AppColors.white, size: 24.sp),
        ),
        const Spacer(),
        Text(
          dashboard == null
              ? AppStrings.appName
              : '${AppStrings.welcomeBack} ${dashboard!.fullName}',
          style: AppFonts.tajawalBold16.copyWith(color: AppColors.white),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HomeDoctorItem(hasTherapist: dashboard?.nextSession != null),
            SubscriptionCard(dashboard: dashboard),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final DashboardModel? dashboard;

  const SubscriptionCard({super.key, this.dashboard});

  @override
  Widget build(BuildContext context) {
    final latest = dashboard?.latestAssessment;
    final next = dashboard?.nextSession;
    return CustomCard(
      margin: EdgeInsets.all(AppSizes.lgRadius),
      borderRadius: BorderRadius.circular(AppSizes.xlRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(AppStrings.nextSession,
                  style: AppFonts.tajawalRegular14
                      .copyWith(color: AppColors.textGray)),
              const Spacer(),
              Text(
                next == null
                    ? AppStrings.noUpcomingSession
                    : '${next.sessionDate} • ${next.sessionTime}',
                style:
                    AppFonts.tajawalBold16.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            latest == null
                ? AppStrings.noAssessmentYet
                : '${AppStrings.latestAssessment}: ${latest.type.toUpperCase()} — ${latest.score}',
            style: AppFonts.tajawalBold18,
          ),
          if (latest != null && latest.interpretation.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(latest.interpretation,
                style: AppFonts.tajawalRegular12
                    .copyWith(color: AppColors.textGray)),
          ],
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.complianceLevel,
                  style: AppFonts.tajawalRegular12
                      .copyWith(color: AppColors.textGray)),
              Text(dashboard?.complianceLevel ?? '-',
                  style: AppFonts.tajawalRegular12
                      .copyWith(color: AppColors.textGray)),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeDoctorItem extends StatelessWidget {
  final bool hasTherapist;

  const HomeDoctorItem({super.key, required this.hasTherapist});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.lgPadding),
      backgroundColor: Colors.white.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(AppSizes.mdRadius),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.h,
            backgroundColor: AppColors.greyF6,
            child: Icon(Iconsax.user, color: AppColors.primary, size: 30.sp),
          ),
          SizedBox(width: 10.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.yourTherapist, style: AppFonts.tajawalRegular14),
              Text(
                hasTherapist
                    ? AppStrings.therapistAssigned
                    : AppStrings.noTherapistYet,
                style: AppFonts.tajawalRegular14,
              ),
            ],
          ),
          const Spacer(),
          CustomButton(
            text: AppStrings.browseTherapists,
            onPressed: () =>
                Modular.to.pushNamed(AppRouteName.availableOptions),
            color: AppColors.white,
            textColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
