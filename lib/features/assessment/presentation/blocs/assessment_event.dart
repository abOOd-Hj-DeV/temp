part of 'assessment_bloc.dart';

sealed class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object?> get props => [];
}

final class AssessmentStarted extends AssessmentEvent {
  final AssessmentType type;
  const AssessmentStarted(this.type);

  @override
  List<Object?> get props => [type];
}

/// قيمة الإجابة للسؤال الحالي (0..3)
final class AssessmentAnswered extends AssessmentEvent {
  final int value;
  const AssessmentAnswered(this.value);

  @override
  List<Object?> get props => [value];
}

final class AssessmentWentBack extends AssessmentEvent {
  const AssessmentWentBack();
}

final class AssessmentSubmitted extends AssessmentEvent {
  const AssessmentSubmitted();
}
