import 'package:etmaen/core/api/api_consumer.dart';

class HomeApiService {
  final ApiConsumer api;
  HomeApiService(this.api);

  Future<Map<String, dynamic>> getWeeklyStats({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "stat1",
          "user": "user1",
          "week_start": "2024-01-01",
          "mood_score": 7.5,
          "sessions_completed": 2,
          "goals_achieved": 3,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
      ],
      "totalItems": 1,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getUserPrograms({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "userprog1",
          "user": "user1",
          "program": "program1",
          "enrollment_date": "2024-01-01",
          "status": "active",
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
      ],
      "totalItems": 1,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getMoodEntries({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "mood1",
          "user": "user1",
          "mood": "good",
          "notes": "Bugün iyi hissediyorum.",
          "date": "2024-01-01",
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "mood2",
          "user": "user1",
          "mood": "neutral",
          "notes": "Orta düzey bir gün.",
          "date": "2024-01-02",
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getUpcomingAppointments({
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
}