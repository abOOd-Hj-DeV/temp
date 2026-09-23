import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress/step_progress.dart';

class BookingPageHear extends StatelessWidget {
  const BookingPageHear({
    super.key,
    required this.pageList,
    required StepProgressController stepProgressController,
    required PageController pageViewController,
    required int currentPageIndex,
  })  : _stepProgressController = stepProgressController,
        _pageViewController = pageViewController,
        _currentPageIndex = currentPageIndex;

  final List<Widget> pageList;
  final StepProgressController _stepProgressController;
  final PageController _pageViewController;
  final int _currentPageIndex;

  @override
  Widget build(BuildContext context) {
    final TherapistModel? therapistModel = Modular.args.data as TherapistModel?;
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSizes.mdRadius),
          bottomRight: Radius.circular(AppSizes.mdRadius),
        ),
      ),
      expandedHeight: 120.h,
      actionsPadding:
          const EdgeInsets.symmetric(horizontal: AppSizes.mdPadding),
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.lgPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: AppSizes.lgPadding,
                  children: [
                    InkWell(
                      onTap: () {
                        if (_currentPageIndex <= 0) {
                          Modular.to.pop();
                        } else {
                          _stepProgressController.previousStep();
                          _pageViewController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Icon(
                        size: 18.sp,
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      AppStrings.bookFirstSessionTitle,
                      style: AppFonts.tajawalBold18
                          .copyWith(color: AppColors.white),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "${AppStrings.withDoctor} ${therapistModel?.name ?? ''}",
                  style: AppFonts.tajawalRegular16
                      .copyWith(color: AppColors.greyDB),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ),
        collapseMode: CollapseMode.parallax,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.lgPadding,
            right: AppSizes.lgPadding,
            bottom: AppSizes.lgPadding,
          ),
          child: StepProgress(
            totalSteps: pageList.length,
            controller: _stepProgressController,
            currentStep: _stepProgressController.currentStep,
            onStepNodeTapped: (index) {
              final int currentStep = _stepProgressController.currentStep;
              if (currentStep >= index || currentStep == index) {
                _stepProgressController.setCurrentStep(index);
              }
            },
            onStepChanged: (currentIndex) {
              _pageViewController.animateToPage(
                currentIndex,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInToLinear,
              );
            },
            theme: const StepProgressThemeData(
              stepLineSpacing: AppSizes.lgPadding,
              stepLineStyle: StepLineStyle(
                activeColor: AppColors.white,
                foregroundColor: AppColors.greyDB,
              ),
              stepNodeStyle: StepNodeStyle(
                defaultForegroundColor: AppColors.greyDB,
              ),
              stepAnimationDuration: Duration(milliseconds: 150),
              enableRippleEffect: true,
            ),
          ),
        ),
      ),
    );
  }
}
