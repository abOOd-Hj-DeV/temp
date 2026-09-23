import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/profile/presentation/widgets/support_request_card.dart';
import 'package:etmaen/features/profile/presentation/widgets/support_request_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MyRequestsTab extends StatelessWidget {
  const MyRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SupportRequestTitle(
              icon: Iconsax.support,
              title: AppStrings.supportRequestTitle,
            ),
            ...List.generate(
              5,
              (index) => const SupportRequestCard(
                isExpanded: false,
                title: "مشكلة في تحميل الفيديو",
                id: "T-1234",
                status: "قيد المعالجة",
                time: "منذ يوم",
                description:
                    'هنا سوف يكون شرح المشكلة التي  ادخله المستخدم,هنا سوف يكون شرح المشكلة التي  ادخله المستخدمهنا سوف يكون شرح المشكلة ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
