import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/features/introduction/data/local/onboarding_data_list.dart';
import 'package:etmaen/features/introduction/presentation/widget/onboarding_info_card.dart';
import 'package:etmaen/features/introduction/presentation/widget/onboarding_slider.dart';
import 'package:etmaen/shared/services/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int index = 0;
  final int length = OnboardingDataList.onboardingDataList.length;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: index);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (index >= length - 1) {
      _navigate();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }

  void _navigate() {
    SharedPrefHelper.setBool(SharedPrefHelper.onboardingSeenKey, true);
    Modular.to.navigate(AppRouteName.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 0.75.sh,
            child: OnboardingSlider(
              pageController: pageController,
              onPageChanged: (idx) {
                setState(() {
                  index = idx;
                });
              },
              data: OnboardingDataList.onboardingDataList,
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: OnboardingInfoCard(
              currentIndex: index,
              totalLength: length,
              currentData: OnboardingDataList.onboardingDataList[index],
              onNext: _onNext,
              onSkip: _navigate,
            ),
          ),
        ],
      ),
    );
  }
}
