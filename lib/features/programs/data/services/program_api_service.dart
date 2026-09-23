import 'package:etmaen/core/api/api_consumer.dart';

class ProgramApiService {
  final ApiConsumer api;
  ProgramApiService(this.api);

  Future<Map<String, dynamic>> getPrograms({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "program1",
          "name": "Anksiyete Yönetimi Programı",
          "description": "8 haftalık bireysel terapi programı",
          "duration_weeks": 8,
          "sessions_per_week": 2,
          "price": 2400.0,
          "original_price": 3000.0,
          "is_popular": true,
          "features": ["Bireysel seanslar", "Ev ödevleri", "Sürekli destek"],
          "image": null,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "program2",
          "name": "Depresyon İyileşme Programı",
          "description": "12 haftalık grup ve bireysel terapi",
          "duration_weeks": 12,
          "sessions_per_week": 3,
          "price": 3600.0,
          "original_price": 4500.0,
          "is_popular": true,
          "features": ["Grup seansları", "Bireysel seanslar", "Aile desteği"],
          "image": null,
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getProgramById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "name": "Anksiyete Yönetimi Programı",
      "description": "8 haftalık bireysel terapi programı",
      "duration_weeks": 8,
      "sessions_per_week": 2,
      "price": 2400.0,
      "original_price": 3000.0,
      "is_popular": true,
      "features": ["Bireysel seanslar", "Ev ödevleri", "Sürekli destek"],
      "image": null,
      "created": "2024-01-01 00:00:00",
      "updated": "2024-01-01 00:00:00",
    };
  }

  Future<Map<String, dynamic>> getModulesByProgram(String programId, {
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "module1",
          "program": programId,
          "title": "Tanışma Modülü",
          "description": "Programa hoş geldiniz.",
          "order": 1,
          "duration_days": 7,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        }
      ]
    };
  }

  Future<Map<String, dynamic>> getProgramModuleById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "program": "program1",
      "title": "Tanışma Modülü",
      "description": "Programa hoş geldiniz.",
      "order": 1,
      "duration_days": 7,
      "created": "2024-01-01 00:00:00",
      "updated": "2024-01-01 00:00:00",
    };
  }
}