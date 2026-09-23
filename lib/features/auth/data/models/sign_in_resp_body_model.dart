import 'package:etmaen/features/auth/data/models/user_model.dart';

/// PocketBase giriş yanıtı: { token, record }
class SignInRespBodyModel {
  final String token;
  final UserModel user;

  SignInRespBodyModel({required this.token, required this.user});

  factory SignInRespBodyModel.fromJson(Map<String, dynamic> jsonData) {
    return SignInRespBodyModel(
      token: jsonData["token"] ?? '',
      user: UserModel.fromJson(jsonData["record"] ?? {}),
    );
  }
}