class TherapistReviewModel {
  final String id;
  final String user;
  final int rating;
  final String comment;

  const TherapistReviewModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.comment,
  });

  factory TherapistReviewModel.fromJson(Map<String, dynamic> json) {
    return TherapistReviewModel(
      id: json['id'] as String,
      user: json['user'] as String,
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'rating': rating,
        'comment': comment,
      };

  static List<TherapistReviewModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => TherapistReviewModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
