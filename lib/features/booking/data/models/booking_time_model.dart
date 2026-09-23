class BookingTimeModel {
  final String id;
  final String time;
  BookingTimeModel({required this.id, required this.time});
  factory BookingTimeModel.fromJson(Map<String, dynamic> json) {
    return BookingTimeModel(
      id: json['id'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'daye_name': id,
      'time': time,
    };
  }

  static List<BookingTimeModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => BookingTimeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
