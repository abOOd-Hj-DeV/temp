import 'package:etmaen/core/api/api_consumer.dart';

class EmergencyApiService {
  final ApiConsumer api;
  EmergencyApiService(this.api);

  Future<Map<String, dynamic>> getEmergencyContacts({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "emergency1",
          "name": "Ali Yılmaz",
          "phone": "+905551111111",
          "relation": "Anne",
          "user": "user1",
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "emergency2",
          "name": "Ayşe Yılmaz",
          "phone": "+905552222222",
          "relation": "Eş",
          "user": "user1",
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }
}