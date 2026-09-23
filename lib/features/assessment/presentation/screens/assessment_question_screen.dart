import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/assessment/data/models/assessment_option_model.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_cubit.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_state.dart';
import 'package:etmaen/features/assessment/presentation/widgets/answer_option.dart';
import 'package:etmaen/features/assessment/presentation/widgets/progress_indicator.dart';
import 'package:etmaen/features/assessment/presentation/widgets/uestion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssessmentQuestionScreen extends StatefulWidget {
  const AssessmentQuestionScreen({super.key});

  @override
  State<AssessmentQuestionScreen> createState() =>
      _AssessmentQuestionScreenState();
}

class _AssessmentQuestionScreenState extends State<AssessmentQuestionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    context.read<AssessmentCubit>().getAssessments();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    super.initState();
  }

  void _onOptionSelected(
      {required AssessmentQuestionModel question, required int index}) {
    if (_currentPage < index) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<AssessmentCubit>().submitAssessment(question: question);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
          child: BlocBuilder<AssessmentCubit, AssessmentState>(
            builder: (context, state) {
              switch (state) {
                case AssessmentFailure():
                  return Center(
                    child: Text(state.error),
                  );
                case AssessmentLoading():
                  return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary));
                case AssessmentsLoaded():
                  if (state.assessment.isEmpty) {
                    return const Center(
                      child: Text(AppStrings.assessmentEmitData),
                    );
                  }
                  final questions = state.assessment.first.questions;
                  return Column(
                    children: [
                      SizedBox(height: 16.h),
                      AssessmentProgressIndicator(
                        currentQuestion: _currentPage + 1,
                        totalQuestions: questions.length,
                      ),
                      SizedBox(height: 24.h),
                      QuestionCard(
                        question: questions[_currentPage].question,
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: questions.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, pageIndex) {
                            final question = questions[pageIndex];
                            return ListView.separated(
                              itemCount: question.options.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 8.h),
                              itemBuilder: (context, index) {
                                return AnswerOption(
                                  text: question.options[index],
                                  onTap: () {
                                    _onOptionSelected(
                                      question: AssessmentQuestionModel(
                                        id: 0,
                                        question: '',
                                        options: [],
                                      ),
                                      index: state.assessment.first.questions
                                              .length -
                                          1,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
