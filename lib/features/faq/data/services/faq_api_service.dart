import 'package:etmaen/core/api/api_consumer.dart';

class FaqApiService {
  final ApiConsumer api;
  FaqApiService(this.api);

  Future<Map<String, dynamic>> getFaqs({
    Map<String, dynamic>? queryParameters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "items": [
        {
          "id": "faq1",
          "question": "Randevu nasıl alırım?",
          "answer": "Uygulamadan terapiçinizi seçip uygun zamanı seçerek randevu alabilirsiniz.",
          "category": "Randevu",
          "created": "2024-01-01 00:00:00",
          "updated": "2024-01-01 00:00:00",
        },
        {
          "id": "faq2",
          "question": "Ödeme yöntemleri neler?",
          "answer": "Kredi kartı, banka kartı ve taksit seçenekleri mevcuttur.",
          "category": "Ödeme",
          "created": "2024-01-02 00:00:00",
          "updated": "2024-01-02 00:00:00",
        },
        {
          "id": "faq3",
          "question": "Terapistimi nasıl değerlendirebilirim?",
          "answer": "Seans bittikten sonra uygulama üzerinden terapistinizi değerlendirebilirsiniz.",
          "category": "Değerlendirme",
          "created": "2024-01-03 00:00:00",
          "updated": "2024-01-03 00:00:00",
        },
      ],
      "totalItems": 3,
      "page": 1,
      "perPage": 20,
    };
  }
}