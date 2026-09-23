import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

enum LegalDocument { privacyPolicy, termsAndConditions }

/// سياسة الخصوصية والشروط — نص ثابت حتى يوفّر الباك‑إند المحتوى
class LegalPage extends StatelessWidget {
  final LegalDocument document;

  const LegalPage({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    final (title, body) = switch (document) {
      LegalDocument.privacyPolicy => (
          AppStrings.privacyPolicy,
          AppStrings.privacyPolicyBody
        ),
      LegalDocument.termsAndConditions => (
          AppStrings.termsAndConditions,
          AppStrings.termsAndConditionsBody
        ),
    };
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lgPadding),
        child: Text(
          body,
          style: AppFonts.tajawalRegular14
              .copyWith(color: AppColors.textGray, height: 1.8),
        ),
      ),
    );
  }
}
