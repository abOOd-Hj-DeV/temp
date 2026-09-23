import 'package:equatable/equatable.dart';

/// جلسة علاجية كما يعيدها `patients/appointments` و`dashboard.next_session`
class SessionModel extends Equatable {
  final String id;
  final String therapistId;
  final String sessionDate;
  final String sessionTime;
  final String medium;
  final String status;
  final bool isInitial;
  final String paymentStatus;
  final double price;

  const SessionModel({
    required this.id,
    required this.therapistId,
    required this.sessionDate,
    required this.sessionTime,
    required this.medium,
    required this.status,
    required this.isInitial,
    required this.paymentStatus,
    required this.price,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id']?.toString() ?? '',
      therapistId: json['therapist_id']?.toString() ?? '',
      sessionDate: json['session_date']?.toString() ?? '',
      sessionTime: json['session_time']?.toString() ?? '',
      medium: json['medium']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      isInitial: json['is_initial'] == true,
      paymentStatus: json['payment_status']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ??
          double.tryParse('${json['price']}') ??
          0,
    );
  }

  DateTime? get dateTime => DateTime.tryParse(sessionDate);

  String get mediumLabel => switch (medium) {
        'video' => 'مكالمة فيديو',
        'audio' => 'مكالمة صوتية',
        'chat' => 'دردشة',
        'in_person' => 'حضوري',
        _ => medium,
      };

  String get statusLabel => switch (status) {
        'scheduled' => 'مجدولة',
        'confirmed' => 'مؤكدة',
        'completed' => 'مكتملة',
        'cancelled' => 'ملغاة',
        'no_show' => 'لم يحضر',
        _ => status,
      };

  String get paymentStatusLabel => switch (paymentStatus) {
        'paid' => 'مدفوعة',
        'pending' => 'بانتظار الدفع',
        'failed' => 'فشل الدفع',
        'refunded' => 'مستردة',
        _ => paymentStatus,
      };

  @override
  List<Object?> get props => [
        id,
        therapistId,
        sessionDate,
        sessionTime,
        medium,
        status,
        isInitial,
        paymentStatus,
        price,
      ];
}
