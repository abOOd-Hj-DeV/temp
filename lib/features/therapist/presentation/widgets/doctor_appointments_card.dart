import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/therapist/data/models/therapist_availability_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/widgets.dart';

class DoctorAppointments extends StatelessWidget {
  final TherapistAvailabilityModel availability;
  const DoctorAppointments({
    super.key,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    final days = availability.availabilityTime.entries.toList();
    return CustomCard(
        margin: const EdgeInsets.all(
          AppSizes.lgPadding,
        ),
        child: Column(
          spacing: AppSizes.mdPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.briefOverview,
              style: AppFonts.tajawalBold16,
            ),
            ...List.generate(
              days.length,
              (index) {
                final day = days[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSizes.smPadding),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day.key,
                        style: AppFonts.tajawalRegular16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          ...List.generate(
                            day.value.length > 3 ? 3 : day.value.length,
                            (index) => Container(
                              padding: const EdgeInsets.all(AppSizes.mdPadding),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.xsRadius),
                              ),
                              child: Text(
                                day.value[index],
                                style: AppFonts.tajawalRegular14
                                    .copyWith(color: AppColors.textGray36),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}