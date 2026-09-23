import 'package:etmaen/features/introduction/data/model/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingSlider extends StatelessWidget {
  final PageController pageController;
  final Function(int) onPageChanged;
  final List<OnboardingModel> data;

  const OnboardingSlider({
    required this.pageController,
    required this.onPageChanged,
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) => SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          fit: BoxFit.fill,
          data[index].image,
        ),
      ),
    );
  }
}
