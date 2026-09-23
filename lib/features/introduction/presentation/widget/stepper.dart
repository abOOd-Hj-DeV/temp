import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingStepper extends StatelessWidget {
  final int index;
  final int length;
  const OnboardingStepper({
    super.key,
    required this.index,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...List.generate(
          length,
          (currentIndex) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: AppSizes.xsPadding),
            child: Container(
              height: 10,
              width: index == currentIndex ? 34 : 10,
              decoration: BoxDecoration(
                color: index == currentIndex
                    ? AppColors.primary
                    : AppColors.mintGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.mdRadius),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
