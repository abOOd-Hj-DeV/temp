import 'package:etmaen/core/api/api_consumer.dart';
import 'package:etmaen/core/api/end_points.dart';

/// استدعاءات `/api/v1/auth/*`
class AuthApiService {
  final ApiConsumer api;

  AuthApiService(this.api);

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String whatsappNumber,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await api.post(EndPoint.register, data: {
      'name': name,
      'email': email,
      'whatsapp_number': whatsappNumber,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    return _asMap(response);
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String whatsappNumber,
    required String otp,
  }) async {
    final response = await api.post(EndPoint.verifyOtp, data: {
      'whatsapp_number': whatsappNumber,
      'otp': otp,
    });
    return _asMap(response);
  }

  Future<Map<String, dynamic>> resendOtp(String whatsappNumber) async {
    final response = await api.post(EndPoint.resendOtp, data: {
      'whatsapp_number': whatsappNumber,
    });
    return _asMap(response);
  }

  Future<Map<String, dynamic>> login({
    required String whatsappNumber,
    required String password,
  }) async {
    final response = await api.post(EndPoint.login, data: {
      'whatsapp_number': whatsappNumber,
      'password': password,
    });
    return _asMap(response);
  }

  Future<Map<String, dynamic>> forgotPassword(String whatsappNumber) async {
    final response = await api.post(EndPoint.forgotPassword, data: {
      'whatsapp_number': whatsappNumber,
    });
    return _asMap(response);
  }

  Future<Map<String, dynamic>> resetPassword({
    required String whatsappNumber,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await api.post(EndPoint.resetPassword, data: {
      'whatsapp_number': whatsappNumber,
      'otp': otp,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    return _asMap(response);
  }

  Future<Map<String, dynamic>> currentUser() async {
    final response = await api.get(EndPoint.currentUser);
    return _asMap(response);
  }

  Future<Map<String, dynamic>> logout() async {
    final response = await api.post(EndPoint.logout);
    return _asMap(response);
  }

  Map<String, dynamic> _asMap(dynamic response) =>
      response is Map<String, dynamic> ? response : <String, dynamic>{};
}
