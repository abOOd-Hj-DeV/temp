import 'package:etmaen/core/api/api_consumer.dart';

class ProfileApiService {
  final ApiConsumer api;
  ProfileApiService(this.api);

  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": userId,
      "email": "demo@etmaen.com",
      "name": "Demo Kullanıcı",
      "phone": "+905551234567",
      "age": 28,
      "gender": "male",
      "date_of_birth": "1996-05-15",
      "avatar": "",
      "emailVisibility": true,
      "verified": true,
      "created": "2024-01-01 00:00:00",
      "updated": "2024-01-01 00:00:00",
    };
  }

  Future<Map<String, dynamic>> updateUserProfile(
    String userId,
    Map<String, dynamic> data, {
    bool isFromData = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": userId,
      ...data,
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> getSupportTickets({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "ticket1",
          "user": "user1",
          "subject": "Teknik Sorun",
          "message": "Uygulama açılmıyor.",
          "status": "open",
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
      ],
      "totalItems": 1,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> createSupportTicket(
    Map<String, dynamic> data, {
    bool isFromData = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": "ticket_${DateTime.now().millisecondsSinceEpoch}",
      ...data,
      "status": "open",
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };
  }
}