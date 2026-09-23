import 'package:etmaen/core/api/api_consumer.dart';

/// PocketBase appointments koleksiyonu API servisi
class AppointmentApiService {
  final ApiConsumer api;

  AppointmentApiService(this.api);

  Future<Map<String, dynamic>> getAppointments({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "appointment1",
          "user": "user1",
          "therapist": "therapist1",
          "date": "2024-02-15",
          "time": "14:00",
          "duration_minutes": 50,
          "method": "zoom",
          "meeting_link": "https://zoom.us/j/123456789",
          "status": "upcoming",
          "is_initial": true,
          "price": 600.0,
          "session_report": null,
          "therapist_summary": null,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
          "expand": {
            "therapist": {
              "id": "therapist1",
              "full_name": "Dr. Ayşe Demir",
              "avatar": "",
            },
            "user": {
              "id": "user1",
              "name": "Demo Kullanıcı",
            },
          }
        },
      ],
      "totalItems": 1,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getAppointmentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "user": "user1",
      "therapist": "therapist1",
      "date": "2024-02-15",
      "time": "14:00",
      "duration_minutes": 50,
      "method": "zoom",
      "meeting_link": "https://zoom.us/j/123456789",
      "status": "upcoming",
      "is_initial": true,
      "price": 600.0,
      "session_report": null,
      "therapist_summary": null,
      "created": "2024-01-01 00:00:00",
      "updated": "2024-01-01 00:00:00",
    };
  }

  Future<Map<String, dynamic>> createAppointment(
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": "new_appointment_${DateTime.now().millisecondsSinceEpoch}",
      ...data,
      "status": "upcoming",
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> updateAppointment(
    String id,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      ...data,
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> deleteAppointment(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {};
  }
}