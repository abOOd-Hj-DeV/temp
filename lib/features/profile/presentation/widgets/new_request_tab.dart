import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/profile/presentation/widgets/faq_tile.dart';
import 'package:etmaen/features/profile/presentation/widgets/support_request_title.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class NewRequestTab extends StatelessWidget {
  const NewRequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SupportRequestTitle(
            icon: Iconsax.info_circle,
            title: AppStrings.commonQuestions,
          ),
          CustomCard(
            margin: const EdgeInsets.only(bottom: AppSizes.lgPadding),
            child: const Column(
              children: [
                FAQTile(
                  question: "كيف يمكنني حجز جلسة إضافية؟",
                  answer:
                      "هنا سوف يكون شرح المشكلة التي ادخله المستخدم,هنا سوف يكون شرح المشكلة التي ادخله المستخدمهنا سوف يكون شرح المشكلة",
                  isExpanded: false,
                ),
                FAQTile(
                  question: "ماذا لو فاتني موعد جلسة؟",
                  answer:
                      "هنا سوف يكون شرح المشكلة التي ادخله المستخدم,هنا سوف يكون شرح المشكلة التي ادخله المستخدمهنا سوف يكون شرح المشكلة",
                  isExpanded: false,
                ),
                FAQTile(
                  question: "كيف أتواصل مع معالجي خارج الجلسات؟",
                  answer:
                      "هنا سوف يكون شرح المشكلة التي ادخله المستخدم,هنا سوف يكون شرح المشكلة التي ادخله المستخدمهنا سوف يكون شرح المشكلة",
                  isExpanded: false,
                ),
                FAQTile(
                  question: "هل يمكنني تغيير المعالج؟",
                  answer:
                      "هنا سوف يكون شرح المشكلة التي ادخله المستخدم,هنا سوف يكون شرح المشكلة التي ادخله المستخدمهنا سوف يكون شرح المشكلة",
                  isExpanded: false,
                ),
              ],
            ),
          ),
          SupportRequestTitle(
            icon: Iconsax.message,
            title: AppStrings.submitSupportRequest,
          ),
          _buildTextField(
              hint: AppStrings.subjectHint, label: AppStrings.subject),
          _buildTextField(
              hint: AppStrings.detailsHint,
              maxLines: 4,
              label: AppStrings.details),
          _buildFileUpload(),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: AppStrings.sendRequest,
              onPressed: () {},
              color: AppColors.primary,
              textColor: AppColors.white,
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String hint, int maxLines = 1, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.tajawalRegular16.copyWith(color: AppColors.textBlack),
        ),
        CustomCard(
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(
            bottom: AppSizes.lgPadding,
            top: AppSizes.smPadding,
          ),
          borderRadius: BorderRadius.circular(AppSizes.slRadius),
          child: TextField(
            maxLines: maxLines,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppFonts.tajawalRegular14.copyWith(
                color: AppColors.greyAA,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.slRadius),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.uploadFile,
          style: AppFonts.tajawalRegular16.copyWith(color: AppColors.textBlack),
        ),
        CustomCard(
          borderRadius: BorderRadius.circular(AppSizes.slRadius),
          margin: const EdgeInsets.only(
              bottom: AppSizes.lgPadding, top: AppSizes.smPadding),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            spacing: 8.h,
            children: [
              const Icon(
                Icons.file_upload_outlined,
                color: AppColors.textGray99,
                size: 32,
              ),
              Text(
                AppStrings.uploadFileHint,
                textAlign: TextAlign.center,
                style: AppFonts.tajawalRegular14.copyWith(
                  color: AppColors.textGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
