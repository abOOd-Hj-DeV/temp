import 'package:etmaen/core/api/api_consumer.dart';

/// لا يوفر الباك‑إند حالياً endpoints للحجز؛ بيانات محلية مؤقتة.
class BookingApiService {
  ApiConsumer api;

  BookingApiService(this.api);

  Future<Map<String, dynamic>> getBookingDatesByTherapist(
      String therapistId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "slot1",
          "therapist": therapistId,
          "date": "2024-02-15",
          "is_available": true,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "slot2",
          "therapist": therapistId,
          "date": "2024-02-16",
          "is_available": true,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getBookingTimesBySlot(String slotId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "time1",
          "slot": slotId,
          "time": "09:00",
          "is_available": true,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "time2",
          "slot": slotId,
          "time": "10:00",
          "is_available": true,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "time3",
          "slot": slotId,
          "time": "11:00",
          "is_available": false,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
      ],
      "totalItems": 3,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getBookingMethodsBySlot(String soltId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "method1",
          "name": "online",
          "icon": "video_call",
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "method2",
          "name": "in_person",
          "icon": "person",
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> bookingAppointment(
      Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": "new_appointment_${DateTime.now().millisecondsSinceEpoch}",
      ...data,
      "status": "upcoming",
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> bookingApprove(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "is_booked": true,
      "updated": DateTime.now().toIso8601String(),
    };
  }
}
