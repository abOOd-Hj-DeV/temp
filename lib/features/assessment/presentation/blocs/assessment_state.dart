import 'package:equatable/equatable.dart';
import 'package:etmaen/features/assessment/data/models/assessment_templates.dart';

abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object?> get props => [];
}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}

class AssessmentsLoaded extends AssessmentState {
  final List<AssessmentTemplateModel> assessment;

  const AssessmentsLoaded({required this.assessment});

  @override
  List<Object?> get props => [assessment];
}

class AssessmentFailure extends AssessmentState {
  final String error;

  const AssessmentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class AssessmentSubmitted extends AssessmentState {
  const AssessmentSubmitted();

  @override
  List<Object?> get props => [];
}
