import 'package:etmaen/core/api/api_consumer.dart';

class NotificationApiService {
  final ApiConsumer api;
  NotificationApiService(this.api);

  Future<Map<String, dynamic>> getNotifications({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "notif1",
          "user": "user1",
          "title": "Yeni Randevu Hatırlatması",
          "body": "Yarın Dr. Ayşe Demir ile randevunuz var.",
          "type": "appointment",
          "is_read": false,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "notif2",
          "user": "user1",
          "title": "Program Güncellemesi",
          "body": "Anksiyete Yönetimi Programı'na yeni modül eklendi.",
          "type": "program",
          "is_read": true,
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "is_read": true,
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> markAllAsRead(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [],
      "totalItems": 0,
      "page": 1,
      "perPage": 100,
    };
  }
}