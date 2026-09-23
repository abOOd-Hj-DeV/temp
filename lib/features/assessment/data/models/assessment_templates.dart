import 'package:etmaen/features/assessment/data/models/assessment_option_model.dart';

/// PocketBase assessment_templates koleksiyonu modeli
class AssessmentTemplateModel {
  final String collectionId;
  final String collectionName;
  final String id;
  final String description;
  final String scaleType;
  final List<AssessmentQuestionModel> questions;
  final double totalQuestions;
  final String createdBy;

  AssessmentTemplateModel({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.description,
    required this.scaleType,
    required this.questions,
    required this.totalQuestions,
    required this.createdBy,
  });

  factory AssessmentTemplateModel.fromJson(Map<String, dynamic> json) {
    final rawQuestions = json['questions'];

    List<AssessmentQuestionModel> parsedQuestions = [];
    if (rawQuestions is List) {
      parsedQuestions = AssessmentQuestionModel.fromJsonList(rawQuestions);
    }

    return AssessmentTemplateModel(
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      scaleType: json['scale_type'] ?? '',
      questions: parsedQuestions,
      totalQuestions: (json['total_questions'] as num?)?.toDouble() ?? 0.0,
      createdBy: json['created_by'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'collectionName': collectionName,
      'id': id,
      'description': description,
      'scale_type': scaleType,
      'questions': questions.map((q) => q.toJson()).toList(),
      'total_questions': totalQuestions,
      'created_by': createdBy,
    };
  }

  



  static List<AssessmentTemplateModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => AssessmentTemplateModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
