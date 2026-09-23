import 'package:equatable/equatable.dart';

class ProgressScore extends Equatable {
  final String type;
  final int score;
  final String date;

  const ProgressScore(
      {required this.type, required this.score, required this.date});

  factory ProgressScore.fromJson(Map<String, dynamic> json) => ProgressScore(
        type: json['type']?.toString() ?? '',
        score: (json['score'] as num?)?.toInt() ?? 0,
        date: json['date']?.toString() ?? '',
      );

  @override
  List<Object?> get props => [type, score, date];
}

class ProgressModel extends Equatable {
  final int assessmentCount;
  final List<ProgressScore> recentScores;
  final int? currentScore;
  final String complianceLevel;

  const ProgressModel({
    required this.assessmentCount,
    required this.recentScores,
    required this.currentScore,
    required this.complianceLevel,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
        assessmentCount: (json['assessment_count'] as num?)?.toInt() ?? 0,
        recentScores: (json['recent_scores'] as List? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ProgressScore.fromJson)
            .toList(),
        currentScore: (json['current_score'] as num?)?.toInt(),
        complianceLevel: json['compliance_level']?.toString() ?? '',
      );

  @override
  List<Object?> get props =>
      [assessmentCount, recentScores, currentScore, complianceLevel];
}
