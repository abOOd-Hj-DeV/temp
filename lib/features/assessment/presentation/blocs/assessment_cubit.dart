import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/features/assessment/data/models/assessment_option_model.dart';
import 'package:etmaen/features/assessment/data/repositories/assessment_repository.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssessmentCubit extends Cubit<AssessmentState> {
  final AssessmentRepository repository;

  AssessmentCubit(this.repository) : super(AssessmentInitial());

  Future<void> getAssessments() async {
    emit(AssessmentLoading());
    final result = await repository.getAssessments();
    result.fold(
      ifLeft: (failure) => emit(
          AssessmentFailure(error: failure.errorMessage ?? 'Unknown error')),
      ifRight: (assessments) =>
          emit(AssessmentsLoaded(assessment: assessments)),
    );
  }

  Future<void> submitAssessment({
    required AssessmentQuestionModel question,
  }) async {
    emit(AssessmentLoading());
    final result = await repository.submitAssessment({
      "template": "ym090y97murdwwv",
      "user": "lnw5rz4m1oop4wm",
      "answers": {"example": 123},
      "total_score": 123.456,
      "severity": "minimal",
      "therapist_notes": "Lorem ipsum dolor sit amet..."
    });
    result.fold(
      ifLeft: (failure) {
        emit(AssessmentFailure(error: failure.errorMessage!));
      },
      ifRight: (assessments) {
        Modular.to.pushReplacementNamed(AppRouteName.availableOptions);
      },
    );
  }
}
