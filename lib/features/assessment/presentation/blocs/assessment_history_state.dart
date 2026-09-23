part of 'assessment_history_bloc.dart';

sealed class AssessmentHistoryState extends Equatable {
  const AssessmentHistoryState();

  @override
  List<Object?> get props => [];
}

final class AssessmentHistoryInitial extends AssessmentHistoryState {
  const AssessmentHistoryInitial();
}

final class AssessmentHistoryLoading extends AssessmentHistoryState {
  const AssessmentHistoryLoading();
}

final class AssessmentHistoryLoaded extends AssessmentHistoryState {
  final AssessmentHistoryModel history;
  const AssessmentHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

final class AssessmentHistoryFailure extends AssessmentHistoryState {
  final String message;
  const AssessmentHistoryFailure(this.message);

  @override
  List<Object?> get props => [message];
}
