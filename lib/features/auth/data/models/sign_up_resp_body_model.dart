import 'package:etmaen/features/auth/data/models/user_model.dart';

/// PocketBase kayıt yanıtı: PocketBase direk kaydı döndürür
class SignUpRespBodyModel {
  final UserModel user;

  SignUpRespBodyModel({required this.user});

  factory SignUpRespBodyModel.fromJson(Map<String, dynamic> jsonData) {
    return SignUpRespBodyModel(
      user: UserModel.fromJson(jsonData),
    );
  }
}