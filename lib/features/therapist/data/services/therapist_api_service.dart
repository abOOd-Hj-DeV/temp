import 'package:etmaen/core/api/api_consumer.dart';

/// لا يوفر الباك‑إند حالياً endpoint للمعالجين؛ هذه بيانات محلية مؤقتة
/// تُستبدل باستدعاء [api] عند توفر `GET /therapists`.
class TherapistApiService {
  final ApiConsumer api;

  TherapistApiService(this.api);

  Future<Map<String, dynamic>> getTherapists() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "therapist1",
          "full_name": "د. سارة أحمد",
          "title": "أخصائية نفسية إكلينيكية",
          "specialty": "العلاج المعرفي السلوكي",
          "review_count": 45,
          "rating": 4.8,
          "years_of_experience": 8,
          "country": "السعودية",
          "city": "الرياض",
          "district": "العليا",
          "languages": ["العربية", "الإنجليزية"],
          "gender": "female",
          "bio": "خبرة 8 سنوات في علاج القلق والاكتئاب.",
          "avatar": "",
          "is_available": true,
          "is_emergency": false,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "therapist2",
          "full_name": "د. محمد الخالد",
          "title": "طبيب نفسي",
          "specialty": "الاضطراب ثنائي القطب",
          "review_count": 32,
          "rating": 4.6,
          "years_of_experience": 12,
          "country": "السعودية",
          "city": "جدة",
          "district": "الروضة",
          "languages": ["العربية"],
          "gender": "male",
          "bio": "مختص في الطب النفسي للبالغين والمراهقين.",
          "avatar": "",
          "is_available": true,
          "is_emergency": true,
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        },
      ],
      "totalItems": 2,
      "page": 1,
      "perPage": 20,
    };
  }

  Future<Map<String, dynamic>> getTherapistsAvailability(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "avail1",
          "therapist": id,
          "day_of_week": "الاثنين",
          "start_time": "09:00",
          "end_time": "17:00",
          "is_available": true,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        }
      ]
    };
  }

  Future<Map<String, dynamic>> getTherapistById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "full_name": "د. سارة أحمد",
      "title": "أخصائية نفسية إكلينيكية",
      "specialty": "العلاج المعرفي السلوكي",
      "review_count": 45,
      "rating": 4.8,
      "years_of_experience": 8,
      "country": "السعودية",
      "city": "الرياض",
      "district": "العليا",
      "languages": ["العربية", "الإنجليزية"],
      "gender": "female",
      "bio": "خبرة 8 سنوات في علاج القلق والاكتئاب.",
      "avatar": "",
      "is_available": true,
      "is_emergency": false,
      "created": "2024-01-01 00:00:00",
      "updated": "2024-01-01 00:00:00",
    };
  }

  Future<Map<String, dynamic>> getTherapistsReviews(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "review1",
          "therapist": id,
          "user": "user2",
          "rating": 5,
          "comment": "محترفة ومتفهمة جداً.",
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        }
      ]
    };
  }
}
