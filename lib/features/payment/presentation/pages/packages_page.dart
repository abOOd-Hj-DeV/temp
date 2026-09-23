import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/payment/presentation/models/package_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

/// اختيار الباقة — الباقات ثابتة محلياً حتى يوفّر الباك‑إند endpoint عام لها
class PackagesPage extends StatefulWidget {
  const PackagesPage({super.key});

  @override
  State<PackagesPage> createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  int _selected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.choosePackage),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lgPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: PackageModel.available.length,
                itemBuilder: (context, index) {
                  final p = PackageModel.available[index];
                  final selected = index == _selected;
                  return GestureDetector(
                    onTap: () => setState(() => _selected = index),
                    child: CustomCard(
                      margin: EdgeInsets.only(bottom: 12.h),
                      border: Border.all(
                        color: selected ? AppColors.primary : AppColors.grayE6,
                        width: selected ? 1.6 : 1,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(p.name, style: AppFonts.tajawalBold16),
                              const Spacer(),
                              Text('${p.price} ${AppStrings.currency}',
                                  style: AppFonts.tajawalBold18
                                      .copyWith(color: AppColors.primary)),
                            ],
                          ),
                          Text(
                              '${p.sessions} ${AppStrings.sessions} • ${p.durationDays} ${AppStrings.days}',
                              style: AppFonts.tajawalRegular12
                                  .copyWith(color: AppColors.textGray)),
                          SizedBox(height: 8.h),
                          for (final f in p.features)
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Row(
                                children: [
                                  const Icon(Iconsax.tick_circle,
                                      size: 16, color: AppColors.primary),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                      child: Text(f,
                                          style: AppFonts.tajawalRegular14)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              text: AppStrings.continueBtn,
              onPressed: () => Modular.to.pushNamed(
                AppRouteName.paymentSummary,
                arguments: PackageModel.available[_selected],
              ),
              color: AppColors.primary,
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
