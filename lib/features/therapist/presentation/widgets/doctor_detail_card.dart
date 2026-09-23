import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetaislCard extends StatelessWidget {
  final TherapistModel therapist;
  const DetaislCard({
    super.key,
    required this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.briefOverview,
            style: AppFonts.tajawalBold16,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            therapist.bio ?? AppStrings.doctorBio,
            style:
                AppFonts.tajawalRegular14.copyWith(color: AppColors.textGray),
          )
        ],
      ),
    );
  }
}