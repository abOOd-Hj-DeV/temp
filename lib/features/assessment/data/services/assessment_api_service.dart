import 'package:etmaen/core/api/api_consumer.dart';

class AssessmentApiService {
  final ApiConsumer api;

  AssessmentApiService(this.api);

  Future<Map<String, dynamic>> getAssessments({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "assessment1",
          "title": "Anksiyete Ölçeği (GAD-7)",
          "description": "Genel anksiyete düzeyini ölçer",
          "questions": [
            {"id": 1, "text": "Nevrotik hissetmek", "options": ["Hiç", "Birkaç gün", "Haftanın çoğu", "Her gün"]},
            {"id": 2, "text": "Endişelenmek", "options": ["Hiç", "Birkaç gün", "Haftanın çoğu", "Her gün"]},
          ],
          "is_active": true,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "assessment2",
          "title": "Depresyon Ölçeği (PHQ-9)",
          "description": "Depresif belirti düzeyini ölçer",
          "questions": [
            {"id": 1, "text": "Keyifsiz hissetmek", "options": ["Hiç", "Birkaç gün", "Haftanın çoğu", "Her gün"]},
          ],
          "is_active": true,
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> submitAssessment(
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": "user_assessment_${DateTime.now().millisecondsSinceEpoch}",
      ...data,
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> getAssessmentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "title": "Anksiyete Ölçeği (GAD-7)",
      "description": "Genel anksiyete düzeyini ölçer",
      "questions": [
        {"id": 1, "text": "Nevrotik hissetmek", "options": ["Hiç", "Birkaç gün", "Haftanın çoğu", "Her gün"]},
      ],
      "is_active": true,
      "created": "2024-01-01 00:00:00",
      "updated": "2024-01-01 00:00:00",
    };
  }
}
