class AppointmentCardModel {
  // meta
  final int sessionNumber;
  final String dateLabel; // "الاثنين / نوفمبر 24"

  // time
  final String startTimeLabel; // "6:00 مساءً"
  final int durationMinutes; // 50

  // communication (API STRING)
  final String communicationType; // "call" | "chat"
  final String platform; // "zoom" | "whatsapp"

  // note
  final String note;

  // response time
  final String responseTime;

  AppointmentCardModel({
    required this.note,
    required this.responseTime,
    required this.sessionNumber,
    required this.dateLabel,
    required this.startTimeLabel,
    required this.durationMinutes,
    required this.communicationType,
    required this.platform,
  });

  factory AppointmentCardModel.fromApi(Map<String, dynamic> json) {
    return AppointmentCardModel(
      note: json['note'],
      responseTime: json['response_time'],
      sessionNumber: json['session_number'],
      dateLabel: json['date_label'],
      startTimeLabel: json['start_time_label'],
      durationMinutes: json['duration_minutes'],
      communicationType: json['communication_type'],
      platform: json['platform'],
    );
  }
}
