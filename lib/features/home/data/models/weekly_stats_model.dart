/// PocketBase weekly_stats koleksiyonu modeli
class WeeklyStatsModel {
  final String id;
  final String user;
  final String weekStart;
  final int? exercisesCompleted;
  final int? exercisesTotal;
  final int? moodDays;
  final bool? adherenceAlert;
  final String created;
  final String updated;

  WeeklyStatsModel({
    required this.id,
    required this.user,
    required this.weekStart,
    this.exercisesCompleted,
    this.exercisesTotal,
    this.moodDays,
    this.adherenceAlert,
    this.created = '',
    this.updated = '',
  });

  factory WeeklyStatsModel.fromJson(Map<String, dynamic> json) {
    return WeeklyStatsModel(
      id: json['id'] ?? '',
      user: json['user'] ?? '',
      weekStart: json['week_start'] ?? '',
      exercisesCompleted: json['exercises_completed'],
      exercisesTotal: json['exercises_total'],
      moodDays: json['mood_days'],
      adherenceAlert: json['adherence_alert'],
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'week_start': weekStart,
      'exercises_completed': exercisesCompleted,
      'exercises_total': exercisesTotal,
      'mood_days': moodDays,
      'adherence_alert': adherenceAlert,
    };
  }

  static List<WeeklyStatsModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => WeeklyStatsModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}