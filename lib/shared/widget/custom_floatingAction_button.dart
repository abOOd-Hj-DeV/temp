import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class customFloatingActionButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isLoading;
  const customFloatingActionButton({
    super.key,
    this.isLoading = false,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lgPadding),
        child: CustomButton(
          isLoading: isLoading,
          text: text,
          onPressed: onPressed,
          color: AppColors.primary,
          textColor: AppColors.white,
        ),
      ),
    );
  }
}
