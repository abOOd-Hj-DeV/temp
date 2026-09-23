import 'package:etmaen/core/api/api_consumer.dart';

/// PocketBase therapists koleksiyonu API servisi
class TherapistApiService {
  final ApiConsumer api;

  TherapistApiService(this.api);

  Future<Map<String, dynamic>> getTherapists() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "therapist1",
          "full_name": "Dr. Ayşe Demir",
          "title": "Klinik Psikolog",
          "specialty": "Bilişsel Davranışçı Terapi",
          "review_count": 45,
          "rating": 4.8,
          "years_of_experience": 8,
          "country": "Türkiye",
          "city": "İstanbul",
          "district": "Kadıköy",
          "languages": ["Türkçe", "İngilizce"],
          "gender": "female",
          "bio": "Anksiyete ve depresyon konusunda 8 yıllık deneyim.",
          "avatar": "",
          "is_available": true,
          "is_emergency": false,
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "therapist2",
          "full_name": "Dr. Mehmet Kaya",
          "title": "Psikiyatrist",
          "specialty": "Bipolar Bozukluk",
          "review_count": 32,
          "rating": 4.6,
          "years_of_experience": 12,
          "country": "Türkiye",
          "city": "Ankara",
          "district": "Çankaya",
          "languages": ["Türkçe"],
          "gender": "male",
          "bio": "Yetişkin ve ergen psikiyatrisi uzmanı.",
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
          "day_of_week": "Pazartesi",
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
      "full_name": "Dr. Ayşe Demir",
      "title": "Klinik Psikolog",
      "specialty": "Bilişsel Davranışçı Terapi",
      "review_count": 45,
      "rating": 4.8,
      "years_of_experience": 8,
      "country": "Türkiye",
      "city": "İstanbul",
      "district": "Kadıköy",
      "languages": ["Türkçe", "İngilizce"],
      "gender": "female",
      "bio": "Anksiyete ve depresyon konusunda 8 yıllık deneyim.",
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
          "comment": "Çok profesyonel ve anlayışlı.",
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        }
      ]
    };
  }
}
