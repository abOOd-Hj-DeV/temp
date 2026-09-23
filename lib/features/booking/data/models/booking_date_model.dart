class BookingDateModel {
  final String id;
  final String date;
  BookingDateModel({required this.date, required this.id});

  factory BookingDateModel.fromJson(Map<String, dynamic> json) {
    return BookingDateModel(
      date: json['date'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'id': id,
    };
  }

  static List<BookingDateModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => BookingDateModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
