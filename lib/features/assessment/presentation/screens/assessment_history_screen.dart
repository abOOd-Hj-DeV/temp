import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/assessment/data/models/assessment_type.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_history_bloc.dart';
import 'package:etmaen/features/patient/presentation/widgets/state_placeholder.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssessmentHistoryScreen extends StatelessWidget {
  const AssessmentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<AssessmentHistoryBloc>()..add(const AssessmentHistoryRequested()),
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.assessmentHistory),
        body: BlocBuilder<AssessmentHistoryBloc, AssessmentHistoryState>(
          builder: (context, state) {
            switch (state) {
              case AssessmentHistoryLoaded():
                if (state.history.assessments.isEmpty) {
                  return StatePlaceholder(
                    icon: Icons.assignment_outlined,
                    message: AppStrings.noAssessmentYet,
                    actionLabel: AppStrings.startAssessment,
                    onRetry: () => Modular.to
                        .pushNamed(AppRouteName.assessmentIntroScreen),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(AppSizes.lgPadding),
                  itemCount: state.history.assessments.length,
                  itemBuilder: (context, index) {
                    final a = state.history.assessments[index];
                    return CustomCard(
                      margin: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSizes.mdPadding),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(AppSizes.smRadius),
                            ),
                            child: Text('${a.score}',
                                style: AppFonts.tajawalBold18
                                    .copyWith(color: AppColors.primary)),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AssessmentType.fromApi(a.type).title,
                                    style: AppFonts.tajawalMedium16),
                                Text(a.interpretation,
                                    style: AppFonts.tajawalRegular14
                                        .copyWith(color: AppColors.textGray)),
                                Text(a.completedAt,
                                    style: AppFonts.tajawalRegular12
                                        .copyWith(color: AppColors.textGray)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              case AssessmentHistoryFailure():
                return StatePlaceholder(
                  icon: Icons.error_outline,
                  message: state.message,
                  onRetry: () => context
                      .read<AssessmentHistoryBloc>()
                      .add(const AssessmentHistoryRequested()),
                );
              default:
                return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary));
            }
          },
        ),
      ),
    );
  }
}
