import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'forgot_password_state.dart';

/// Cubit لإدارة عملية نسيان كلمة المرور
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository authRepository;

  ForgotPasswordCubit(this.authRepository) : super(ForgotPasswordInitial());

  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    emit(ForgotPasswordSuccess(
      message: "Şifre sıfırlama bağlantısı demo modda gönderildi (Demo)",
    ));
  }
}