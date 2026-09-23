import 'package:equatable/equatable.dart';
import 'package:etmaen/features/auth/data/models/user_model.dart';

/// استجابة تسجيل الدخول / التحقق من OTP: توكن + مستخدم
class AuthSessionModel extends Equatable {
  final String message;
  final String accessToken;
  final String? expiresAt;
  final UserModel user;

  const AuthSessionModel({
    required this.message,
    required this.accessToken,
    required this.user,
    this.expiresAt,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      message: json['message']?.toString() ?? '',
      accessToken: json['access_token']?.toString() ?? '',
      expiresAt: json['expires_at']?.toString(),
      user: UserModel.fromJson(
          (json['user'] as Map<String, dynamic>?) ?? const {}),
    );
  }

  @override
  List<Object?> get props => [message, accessToken, expiresAt, user];
}
