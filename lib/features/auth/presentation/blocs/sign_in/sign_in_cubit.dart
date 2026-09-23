import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/features/auth/data/models/sign_in_resp_body_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:etmaen/shared/services/shared_pref_service.dart';
import 'sign_in_state.dart';

/// Cubit لإدارة حالة تسجيل الدخول
class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;

  SignInCubit(this.authRepository) : super(SignInInitial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(SignInLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    if (email == "demo@etmaen.com" && password == "demo123") {
      final dummyResponse = {
        "token": "demo_token_123456789",
        "record": {
          "id": "user1",
          "email": "demo@etmaen.com",
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

      final model = SignInRespBodyModel.fromJson(dummyResponse);
      await SharedPrefHelper.setSecuredString("token", model.token);
      await SharedPrefHelper.setData("userId", model.user.id);
      emit(SignInSuccess(message: "Giriş başarılı (Demo)"));
      Modular.to.navigate(AppRouteName.assessmentIntroScreen);
    } else {
      emit(SignInFailure(error: "Geçersiz e-posta veya şifre"));
    }
  }
}
