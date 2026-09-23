import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/patient/data/models/session_model.dart';

/// نموذج عرض للبطاقة مشتق من `SessionModel` القادم من الباك‑إند
class AppointmentCardModel {
  final int sessionNumber;
  final String dateLabel;
  final String startTimeLabel;
  final int durationMinutes;
  final String communicationType; // "call" | "chat"
  final String platform; // "zoom" | "whatsapp"
  final String note;
  final String responseTime;
  final String statusLabel;

  const AppointmentCardModel({
    required this.sessionNumber,
    required this.dateLabel,
    required this.startTimeLabel,
    required this.durationMinutes,
    required this.communicationType,
    required this.platform,
    required this.note,
    required this.responseTime,
    required this.statusLabel,
  });

  static const _weekdays = [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];
  static const _months = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  factory AppointmentCardModel.fromSession(SessionModel session, int index) {
    final date = session.dateTime;
    final dateLabel = date == null
        ? session.sessionDate
        : '${_weekdays[date.weekday - 1]} / ${_months[date.month - 1]} ${date.day}';
    return AppointmentCardModel(
      sessionNumber: index + 1,
      dateLabel: dateLabel,
      startTimeLabel: _formatTime(session.sessionTime),
      durationMinutes: 50,
      communicationType: session.medium == 'chat' ? 'chat' : 'call',
      platform: session.medium == 'video' ? 'zoom' : 'whatsapp',
      note: session.isInitial
          ? AppStrings.initialSessionNote
          : AppStrings.appointmentNoteReminder,
      responseTime: session.paymentStatusLabel,
      statusLabel: session.statusLabel,
    );
  }

  static String _formatTime(String raw) {
    final parts = raw.split(':');
    final hour = int.tryParse(parts.first);
    if (hour == null) return raw;
    final minute = parts.length > 1 ? parts[1].padLeft(2, '0') : '00';
    final h12 = hour % 12 == 0 ? 12 : hour % 12;
    final suffix = hour < 12 ? AppStrings.am : AppStrings.pm;
    return '$h12:$minute $suffix';
  }
}
