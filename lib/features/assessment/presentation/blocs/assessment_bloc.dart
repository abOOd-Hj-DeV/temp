import 'package:equatable/equatable.dart';
import 'package:etmaen/features/assessment/data/local/assessment_question_bank.dart';
import 'package:etmaen/features/assessment/data/models/assessment_question_model.dart';
import 'package:etmaen/features/assessment/data/models/assessment_result_model.dart';
import 'package:etmaen/features/assessment/data/models/assessment_type.dart';
import 'package:etmaen/features/assessment/data/repositories/assessment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final AssessmentRepository repository;

  AssessmentBloc(this.repository) : super(const AssessmentInitial()) {
    on<AssessmentStarted>(_onStarted);
    on<AssessmentAnswered>(_onAnswered);
    on<AssessmentWentBack>(_onWentBack);
    on<AssessmentSubmitted>(_onSubmitted);
  }

  void _onStarted(AssessmentStarted event, Emitter<AssessmentState> emit) {
    emit(AssessmentInProgress(
      type: event.type,
      questions: AssessmentQuestionBank.questionsFor(event.type),
      answers: const {},
      currentIndex: 0,
    ));
  }

  void _onAnswered(AssessmentAnswered event, Emitter<AssessmentState> emit) {
    final current = state;
    if (current is! AssessmentInProgress) return;
    final question = current.questions[current.currentIndex];
    final answers = Map<String, int>.from(current.answers)
      ..[question.key] = event.value;
    final isLast = current.currentIndex == current.questions.length - 1;
    emit(current.copyWith(
      answers: answers,
      currentIndex: isLast ? current.currentIndex : current.currentIndex + 1,
    ));
    if (isLast) add(const AssessmentSubmitted());
  }

  void _onWentBack(AssessmentWentBack event, Emitter<AssessmentState> emit) {
    final current = state;
    if (current is! AssessmentInProgress || current.currentIndex == 0) return;
    emit(current.copyWith(currentIndex: current.currentIndex - 1));
  }

  Future<void> _onSubmitted(
      AssessmentSubmitted event, Emitter<AssessmentState> emit) async {
    final current = state;
    if (current is! AssessmentInProgress) return;
    if (current.answers.length != current.questions.length) return;
    emit(AssessmentSubmitting(current));
    final result = await repository.submit(
      type: current.type,
      answers: current.answers,
    );
    result.fold(
      ifLeft: (failure) => emit(AssessmentFailure(
        message: failure.message,
        progress: current,
        profileRequired: failure.hasFieldError('profile'),
      )),
      ifRight: (response) => emit(AssessmentCompleted(response)),
    );
  }
}
