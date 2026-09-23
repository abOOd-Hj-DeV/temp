import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportRequestTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const SupportRequestTitle(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.mdPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style:
                AppFonts.tajawalBold16.copyWith(color: AppColors.textBlackF1),
          ),
        ],
      ),
    );
  }
}
