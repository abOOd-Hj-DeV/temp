import 'package:etmaen/core/api/api_consumer.dart';

class PaymentApiService {
  final ApiConsumer api;
  PaymentApiService(this.api);

  Future<Map<String, dynamic>> getPayments({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "payment1",
          "user": "user1",
          "amount": 600.0,
          "method": "credit_card",
          "status": "completed",
          "appointment": "appointment1",
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "payment2",
          "user": "user1",
          "amount": 2400.0,
          "method": "credit_card",
          "status": "completed",
          "appointment": null,
          "created": "2024-01-15 00:00:00",
          "updated": "2024-01-15 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> createPayment(
    Map<String, dynamic> data, {
    bool isFromData = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": "payment_${DateTime.now().millisecondsSinceEpoch}",
      ...data,
      "status": "pending",
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> updatePayment(
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
}