/// PocketBase appointments koleksiyonu modeli
class AppointmentModel {
  final String id;
  final String user;
  final String therapist;
  final String date;
  final String time;
  final int durationMinutes;
  final String method;
  final String? meetingLink;
  final String status;
  final bool isInitial;
  final double price;
  final String? sessionReport;
  final String? therapistSummary;
  final String created;
  final String updated;

  // Expand edilmiş alanlar
  final String? therapistName;
  final String? therapistAvatar;
  final String? userName;

  AppointmentModel({
    required this.id,
    required this.user,
    required this.therapist,
    required this.date,
    required this.time,
    this.durationMinutes = 50,
    this.method = 'zoom',
    this.meetingLink,
    this.status = 'upcoming',
    this.isInitial = false,
    this.price = 0.0,
    this.sessionReport,
    this.therapistSummary,
    this.created = '',
    this.updated = '',
    this.therapistName,
    this.therapistAvatar,
    this.userName,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    final expand = json['expand'] as Map<String, dynamic>?;

    String? therapistName;
    String? therapistAvatar;
    if (expand != null && expand['therapist'] != null) {
      final t = expand['therapist'] as Map<String, dynamic>;
      therapistName = t['full_name'];
      therapistAvatar = t['avatar'] != null
          ? 'http://127.0.0.1:8090/api/files/therapists/${t['id']}/${t['avatar']}'
          : null;
    }

    return AppointmentModel(
      id: json['id'] ?? '',
      user: json['user'] ?? '',
      therapist: json['therapist'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      durationMinutes: json['duration_minutes'] ?? 50,
      method: json['method'] ?? 'zoom',
      meetingLink: json['meeting_link'],
      status: json['status'] ?? 'upcoming',
      isInitial: json['is_initial'] ?? false,
      price: (json['price'] ?? 0).toDouble(),
      sessionReport: json['session_report'],
      therapistSummary: json['therapist_summary'],
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
      therapistName: therapistName,
      therapistAvatar: therapistAvatar,
      userName: expand?['user']?['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'therapist': therapist,
      'date': date,
      'time': time,
      'duration_minutes': durationMinutes,
      'method': method,
      'meeting_link': meetingLink,
      'status': status,
      'is_initial': isInitial,
      'price': price,
      'session_report': sessionReport,
      'therapist_summary': therapistSummary,
    };
  }

  static List<AppointmentModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}