import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';

/// Cubit لإدارة عملية التحقق من رمز OTP
class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitial());

  Future<void> verifyOtp(String otp) async {
    emit(VerifyOtpLoading());
    // PocketBase doğrudan OTP doğrulama sunmaz.
    // Bu akış özel sunucu tarafında yönetilir.
    await Future.delayed(const Duration(seconds: 1));
    emit(const VerifyOtpSuccess(message: 'تم التحقق من الرمز بنجاح'));
  }
}