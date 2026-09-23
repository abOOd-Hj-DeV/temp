/// PocketBase program_modules koleksiyonu modeli
class ProgramModuleModel {
  final String id;
  final String program;
  final String title;
  final String? description;
  final int durationMinutes;
  final String type;
  final String? contentUrl;
  final int order;
  final String? thumbnail;
  final String created;
  final String updated;

  ProgramModuleModel({
    required this.id,
    required this.program,
    required this.title,
    this.description,
    required this.durationMinutes,
    required this.type,
    this.contentUrl,
    required this.order,
    this.thumbnail,
    this.created = '',
    this.updated = '',
  });

  factory ProgramModuleModel.fromJson(Map<String, dynamic> json) {
    return ProgramModuleModel(
      id: json['id'] ?? '',
      program: json['program'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      durationMinutes: json['duration_minutes'] ?? 0,
      type: json['type'] ?? 'lesson',
      contentUrl: json['content_url'],
      order: json['order'] ?? 0,
      thumbnail: json['thumbnail'],
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'program': program,
      'title': title,
      'description': description,
      'duration_minutes': durationMinutes,
      'type': type,
      'content_url': contentUrl,
      'order': order,
    };
  }

  String? get thumbnailUrl => thumbnail != null
      ? 'http://127.0.0.1:8090/api/files/program_modules/$id/$thumbnail'
      : null;

  static List<ProgramModuleModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => ProgramModuleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}