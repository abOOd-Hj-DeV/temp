part of 'assessment_history_bloc.dart';

sealed class AssessmentHistoryEvent extends Equatable {
  const AssessmentHistoryEvent();

  @override
  List<Object?> get props => [];
}

final class AssessmentHistoryRequested extends AssessmentHistoryEvent {
  const AssessmentHistoryRequested();
}
