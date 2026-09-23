/// PocketBase programs koleksiyonu modeli
class ProgramModel {
  final String id;
  final String name;
  final String? description;
  final int durationWeeks;
  final int sessionsPerWeek;
  final double price;
  final double? originalPrice;
  final bool isPopular;
  final List<String> features;
  final String? image;
  final String created;
  final String updated;

  ProgramModel({
    required this.id,
    required this.name,
    this.description,
    required this.durationWeeks,
    required this.sessionsPerWeek,
    required this.price,
    this.originalPrice,
    this.isPopular = false,
    this.features = const [],
    this.image,
    this.created = '',
    this.updated = '',
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      durationWeeks: json['duration_weeks'] ?? 0,
      sessionsPerWeek: json['sessions_per_week'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      isPopular: json['is_popular'] ?? false,
      features: (json['features'] as List?)?.cast<String>() ?? [],
      image: json['image'],
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'duration_weeks': durationWeeks,
      'sessions_per_week': sessionsPerWeek,
      'price': price,
      'original_price': originalPrice,
      'is_popular': isPopular,
      'features': features,
    };
  }

  /// PocketBase file URL helper
  String? get imageUrl => image != null
      ? 'http://127.0.0.1:8090/api/files/programs/$id/$image'
      : null;

  static List<ProgramModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => ProgramModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}