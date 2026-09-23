/// PocketBase emergency_contacts koleksiyonu modeli
class EmergencyContactModel {
  final String id;
  final String name;
  final String phone;
  final String type;
  final bool? isActive;
  final String? description;
  final String created;
  final String updated;

  EmergencyContactModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.type,
    this.isActive,
    this.description,
    this.created = '',
    this.updated = '',
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      type: json['type'] ?? 'hotline',
      isActive: json['is_active'],
      description: json['description'],
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  static List<EmergencyContactModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => EmergencyContactModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}