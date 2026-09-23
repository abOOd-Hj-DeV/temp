import 'package:etmaen/core/api/api_consumer.dart';

class ChatApiService {
  final ApiConsumer api;
  ChatApiService(this.api);

  Future<Map<String, dynamic>> getMessages({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "msg1",
          "sender": "user1",
          "receiver": "therapist1",
          "content": "Merhaba, randevumu onaylar mısınız?",
          "is_read": false,
          "created": "2024-01-01 10:00:00",
          "updated": "2024-01-01 10:00:00",
        },
        {
          "id": "msg2",
          "sender": "therapist1",
          "receiver": "user1",
          "content": "Merhaba, randevunuz onaylandı.",
          "is_read": true,
          "created": "2024-01-01 10:30:00",
          "updated": "2024-01-01 10:30:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getMessageById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "sender": "user1",
      "receiver": "therapist1",
      "content": "Merhaba, randevumu onaylar mısınız?",
      "is_read": false,
      "created": "2024-01-01 10:00:00",
      "updated": "2024-01-01 10:00:00",
    };
  }

  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": "msg_${DateTime.now().millisecondsSinceEpoch}",
      ...data,
      "is_read": false,
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
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
}