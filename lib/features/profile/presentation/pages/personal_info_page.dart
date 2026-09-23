import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/profile/presentation/widgets/personal_info_card.dart';
import 'package:etmaen/features/profile/presentation/widgets/personal_info_item.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_info_header.dart';
import 'package:flutter/material.dart';

class EditPersonalInfoPage extends StatelessWidget {
  const EditPersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ProfileInfoHeader(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lgPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSizes.lgPadding,
          children: [
            Text(
              AppStrings.currentInfo,
              style: AppFonts.tajawalBold16.copyWith(
                color: AppColors.black12,
              ),
            ),
            PersonalInfoCard(
              items: [
                PersonalInfoItem(
                  label: AppStrings.name,
                  value: 'مستر بين',
                  onEdit: () {},
                ),
                PersonalInfoItem(
                  label: AppStrings.gender,
                  value: AppStrings.male,
                  onEdit: () {},
                ),
                PersonalInfoItem(
                  label: AppStrings.birthDate,
                  value: "1999/7/3",
                  onEdit: () {},
                ),
                const PersonalInfoItem(
                  label: AppStrings.phone,
                  value: "05510986883",
                  showEditIcon: false,
                ),
                const PersonalInfoItem(
                  label: AppStrings.email,
                  value: "bean@gmail.com",
                  showEditIcon: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
