import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/models/session_model.dart';

class DashboardAssessmentSummary extends Equatable {
  final String type;
  final int score;
  final String completedAt;
  final String interpretation;

  const DashboardAssessmentSummary({
    required this.type,
    required this.score,
    required this.completedAt,
    required this.interpretation,
  });

  factory DashboardAssessmentSummary.fromJson(Map<String, dynamic> json) {
    return DashboardAssessmentSummary(
      type: json['type']?.toString() ?? '',
      score: (json['score'] as num?)?.toInt() ?? 0,
      completedAt: json['completed_at']?.toString() ?? '',
      interpretation: json['interpretation']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [type, score, completedAt, interpretation];
}

class DashboardModel extends Equatable {
  final String fullName;
  final String complianceLevel;
  final DashboardAssessmentSummary? latestAssessment;
  final SessionModel? nextSession;
  final List<String> quickActions;

  const DashboardModel({
    required this.fullName,
    required this.complianceLevel,
    required this.latestAssessment,
    required this.nextSession,
    required this.quickActions,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final patient = json['patient'] as Map<String, dynamic>? ?? const {};
    final latest = json['latest_assessment'];
    final next = json['next_session'];
    return DashboardModel(
      fullName: patient['full_name']?.toString() ?? '',
      complianceLevel: patient['compliance_level']?.toString() ?? '',
      latestAssessment: latest is Map<String, dynamic>
          ? DashboardAssessmentSummary.fromJson(latest)
          : null,
      nextSession:
          next is Map<String, dynamic> ? SessionModel.fromJson(next) : null,
      quickActions:
          (json['quick_actions'] as List?)?.map((e) => e.toString()).toList() ??
              const [],
    );
  }

  @override
  List<Object?> get props =>
      [fullName, complianceLevel, latestAssessment, nextSession, quickActions];
}
