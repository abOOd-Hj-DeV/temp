/// PocketBase notifications koleksiyonu modeli
class AppNotificationModel {
  final String id;
  final String user;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final String? relatedId;
  final String created;
  final String updated;

  AppNotificationModel({
    required this.id,
    required this.user,
    required this.title,
    required this.body,
    required this.type,
    this.isRead = false,
    this.relatedId,
    this.created = '',
    this.updated = '',
  });

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) {
    return AppNotificationModel(
      id: json['id'] ?? '',
      user: json['user'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? 'general',
      isRead: json['is_read'] ?? false,
      relatedId: json['related_id'],
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_read': isRead,
    };
  }

  static List<AppNotificationModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => AppNotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}