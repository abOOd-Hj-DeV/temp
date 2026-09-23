/// PocketBase faq koleksiyonu modeli
class FaqModel {
  final String id;
  final String question;
  final String answer;
  final int order;
  final String? category;
  final String created;
  final String updated;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.order,
    this.category,
    this.created = '',
    this.updated = '',
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      order: json['order'] ?? 0,
      category: json['category'],
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  static List<FaqModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}