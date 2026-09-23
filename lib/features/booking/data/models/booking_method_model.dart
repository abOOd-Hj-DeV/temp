class BookingMethodModel {
  final String id;
  final String method;
  BookingMethodModel({required this.id, required this.method});

  factory BookingMethodModel.fromJson(Map<String, dynamic> json) {
    return BookingMethodModel(
      id: json['id'] ?? '',
      method: json['method'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method': method,
    };
  }

  static List<BookingMethodModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => BookingMethodModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
