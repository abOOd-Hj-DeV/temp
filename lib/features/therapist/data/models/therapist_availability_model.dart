class TherapistAvailabilityModel {
  final String id;
  final Map<String, List<String>> availabilityTime;

  const TherapistAvailabilityModel({
    required this.id,
    required this.availabilityTime,
  });

  factory TherapistAvailabilityModel.fromJson(Map<String, dynamic> json) {
    final raw = json['availability_time'];

    return TherapistAvailabilityModel(
      id: json['id'].toString(),
      availabilityTime: raw is Map<String, dynamic>
          ? raw.map((k, v) => MapEntry(k, List<String>.from(v)))
          : {},
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'availability_time': availabilityTime,
      };

  static List<TherapistAvailabilityModel> fromJsonList(
      Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) =>
            TherapistAvailabilityModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
