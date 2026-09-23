import 'package:etmaen/core/api/api_consumer.dart';

/// PocketBase auth servisi
class AuthApiService {
  final ApiConsumer api;

  AuthApiService(this.api);

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "token": "demo_token_123456789",
      "record": {
        "id": "user1",
        "email": email,
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
      }
    };
  }

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    int? age,
    String? gender,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": "user_${DateTime.now().millisecondsSinceEpoch}",
      "email": email,
      "name": name,
      "phone": phone,
      "age": age,
      "gender": gender,
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<String> requestPasswordReset({
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return "Şifre sıfırlama bağlantısı demo modda gönderildi";
  }

  Future<Map<String, dynamic>> confirmPasswordReset({
    required String token,
    required String password,
    required String passwordConfirm,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {"message": "Şifre başarıyla değiştirildi (Demo)"};
  }

  Future<Map<String, dynamic>> updateUser({
    required String id,
    required String email,
    required String password,
    required String name,
    required String phone,
    required int age,
    required String gender,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "email": email,
      "name": name,
      "phone": phone,
      "age": age,
      "gender": gender,
      "updated": DateTime.now().toIso8601String(),
    };
  }

  Future<String> verificationRequest({
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return "Doğrulama bağlantısı demo modda gönderildi";
  }

  Future<String> verificationConfirm({
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return "Hesap başarıyla doğrulandı (Demo)";
  }
}
