import 'package:equatable/equatable.dart';

class AssessmentRecordModel extends Equatable {
  final String id;
  final String type;
  final int score;
  final String completedAt;
  final String interpretation;

  const AssessmentRecordModel({
    required this.id,
    required this.type,
    required this.score,
    required this.completedAt,
    required this.interpretation,
  });

  factory AssessmentRecordModel.fromJson(Map<String, dynamic> json) =>
      AssessmentRecordModel(
        id: json['id']?.toString() ?? '',
        type: json['type']?.toString() ?? '',
        score: (json['score'] as num?)?.toInt() ?? 0,
        completedAt: json['completed_at']?.toString() ?? '',
        interpretation: json['interpretation']?.toString() ?? '',
      );

  @override
  List<Object?> get props => [id, type, score, completedAt, interpretation];
}

/// استجابة `POST patients/assessment`
class AssessmentResultModel extends Equatable {
  final String message;
  final AssessmentRecordModel assessment;
  final String interpretation;
  final List<String> recommendations;
  final bool redFlagCreated;

  const AssessmentResultModel({
    required this.message,
    required this.assessment,
    required this.interpretation,
    required this.recommendations,
    required this.redFlagCreated,
  });

  factory AssessmentResultModel.fromJson(Map<String, dynamic> json) =>
      AssessmentResultModel(
        message: json['message']?.toString() ?? '',
        assessment: AssessmentRecordModel.fromJson(
            (json['assessment'] as Map<String, dynamic>?) ?? const {}),
        interpretation: json['interpretation']?.toString() ?? '',
        recommendations: (json['recommendations'] as List?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
        redFlagCreated: json['red_flag_created'] == true,
      );

  @override
  List<Object?> get props =>
      [message, assessment, interpretation, recommendations, redFlagCreated];
}

/// استجابة `GET patients/assessment/history`
class AssessmentHistoryModel extends Equatable {
  final List<AssessmentRecordModel> assessments;
  final Map<String, dynamic> statistics;

  const AssessmentHistoryModel(
      {required this.assessments, required this.statistics});

  factory AssessmentHistoryModel.fromJson(Map<String, dynamic> json) =>
      AssessmentHistoryModel(
        assessments: (json['assessments'] as List? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(AssessmentRecordModel.fromJson)
            .toList(),
        statistics: (json['statistics'] as Map<String, dynamic>?) ?? const {},
      );

  @override
  List<Object?> get props => [assessments, statistics];
}
