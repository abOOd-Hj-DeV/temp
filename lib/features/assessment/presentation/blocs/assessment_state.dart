part of 'assessment_bloc.dart';

sealed class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object?> get props => [];
}

final class AssessmentInitial extends AssessmentState {
  const AssessmentInitial();
}

final class AssessmentInProgress extends AssessmentState {
  final AssessmentType type;
  final List<AssessmentQuestionModel> questions;
  final Map<String, int> answers;
  final int currentIndex;

  const AssessmentInProgress({
    required this.type,
    required this.questions,
    required this.answers,
    required this.currentIndex,
  });

  AssessmentQuestionModel get currentQuestion => questions[currentIndex];

  int? get currentAnswer => answers[currentQuestion.key];

  AssessmentInProgress copyWith({
    Map<String, int>? answers,
    int? currentIndex,
  }) =>
      AssessmentInProgress(
        type: type,
        questions: questions,
        answers: answers ?? this.answers,
        currentIndex: currentIndex ?? this.currentIndex,
      );

  @override
  List<Object?> get props => [type, questions, answers, currentIndex];
}

final class AssessmentSubmitting extends AssessmentState {
  final AssessmentInProgress progress;
  const AssessmentSubmitting(this.progress);

  @override
  List<Object?> get props => [progress];
}

final class AssessmentCompleted extends AssessmentState {
  final AssessmentResultModel result;
  const AssessmentCompleted(this.result);

  @override
  List<Object?> get props => [result];
}

final class AssessmentFailure extends AssessmentState {
  final String message;
  final AssessmentInProgress progress;
  final bool profileRequired;

  const AssessmentFailure({
    required this.message,
    required this.progress,
    this.profileRequired = false,
  });

  @override
  List<Object?> get props => [message, progress, profileRequired];
}
