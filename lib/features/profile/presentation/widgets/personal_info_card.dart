import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/features/profile/presentation/widgets/personal_info_item.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';

class PersonalInfoCard extends StatelessWidget {
  final List<PersonalInfoItem> items;

  const PersonalInfoCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(AppSizes.slRadius),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: AppColors.textGray500.withOpacity(0.2),
          offset: const Offset(1, 2),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ],
      child: Column(
        children: items,
      ),
    );
  }
}
