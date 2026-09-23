import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/features/assessment/data/local/assessment_question_bank.dart';
import 'package:etmaen/features/assessment/data/models/assessment_type.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_bloc.dart';
import 'package:etmaen/features/assessment/presentation/widgets/answer_option.dart';
import 'package:etmaen/features/assessment/presentation/widgets/progress_indicator.dart';
import 'package:etmaen/features/assessment/presentation/widgets/uestion_card.dart';
import 'package:etmaen/features/patient/presentation/widgets/state_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssessmentQuestionScreen extends StatelessWidget {
  final AssessmentType type;

  const AssessmentQuestionScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssessmentBloc, AssessmentState>(
      listener: (context, state) {
        if (state is AssessmentCompleted) {
          Modular.to.pushReplacementNamed(
            AppRouteName.assessmentResultScreen,
            arguments: state.result,
          );
        } else if (state is AssessmentFailure && !state.profileRequired) {
          AlertService.showError(context, message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
              child: switch (state) {
                AssessmentInProgress() =>
                  _Questions(progress: state, type: type),
                AssessmentSubmitting() => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary)),
                AssessmentFailure(profileRequired: true) => StatePlaceholder(
                    icon: Icons.person_outline,
                    message: AppStrings.profileRequired,
                    actionLabel: AppStrings.completeProfileTitle,
                    onRetry: () =>
                        Modular.to.pushNamed(AppRouteName.completeProfile),
                  ),
                AssessmentFailure() => StatePlaceholder(
                    icon: Icons.error_outline,
                    message: state.message,
                    onRetry: () => context
                        .read<AssessmentBloc>()
                        .add(const AssessmentSubmitted()),
                  ),
                _ => const SizedBox.shrink(),
              },
            ),
          ),
        );
      },
    );
  }
}

class _Questions extends StatelessWidget {
  final AssessmentInProgress progress;
  final AssessmentType type;

  const _Questions({required this.progress, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        AssessmentProgressIndicator(
          title: type.title,
          currentQuestion: progress.currentIndex + 1,
          totalQuestions: progress.questions.length,
          onBack: () {
            if (progress.currentIndex > 0) {
              context.read<AssessmentBloc>().add(const AssessmentWentBack());
            } else {
              Modular.to.pop();
            }
          },
        ),
        SizedBox(height: 20.h),
        QuestionCard(
          question:
              '${AssessmentQuestionBank.intro} ${progress.currentQuestion.question}',
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: AssessmentQuestionBank.options.length,
            itemBuilder: (context, index) => AnswerOption(
              text: AssessmentQuestionBank.options[index],
              isSelected: progress.currentAnswer == index,
              onTap: () =>
                  context.read<AssessmentBloc>().add(AssessmentAnswered(index)),
            ),
          ),
        ),
      ],
    );
  }
}
