import 'package:etmaen/core/constants/app_assets.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/introduction/data/model/onboarding_model.dart';

/// قائمة البيانات onboarding


class OnboardingDataList {
  static List<OnboardingModel> onboardingDataList = [
    OnboardingModel(
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingbody1,
      image: AppAssets.onboarding3,
    ),
    OnboardingModel(
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingbody2,
      image: AppAssets.onboarding1,
    ),
    OnboardingModel(
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingbody3,
      image: AppAssets.onboarding2,
    ),
  ];
}
