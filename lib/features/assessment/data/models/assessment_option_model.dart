/// Değerlendirme sorusu modeli
class AssessmentQuestionModel {
  final int id;
  final String question;
  final List<String> options;

  AssessmentQuestionModel({
    required this.id,
    required this.question,
    required this.options,
  });

  factory AssessmentQuestionModel.fromJson(Map<String, dynamic> json) {
    return AssessmentQuestionModel(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
    };
  }

  /// JSON listesinden model listesine çevirir
  static List<AssessmentQuestionModel> fromJsonList(List<dynamic> json) {
    return json
        .map((e) => AssessmentQuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
