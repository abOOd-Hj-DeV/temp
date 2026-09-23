import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'reset_password_state.dart';

/// Cubit لإدارة عملية تعيين كلمة المرور الجديدة
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository authRepository;

  ResetPasswordCubit(this.authRepository) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    emit(ResetPasswordSuccess(
      message: "Şifre başarıyla değiştirildi (Demo)",
    ));
  }
}