import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'sign_up_state.dart';

/// Cubit لإدارة حالة إنشاء الحساب
class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit(this.authRepository) : super(SignUpInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SignUpLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    emit(SignUpSuccess(message: "Kayıt başarılı (Demo). Giriş yapabilirsiniz."));
    Modular.to.navigate(AppRouteName.signIn);
  }
}
