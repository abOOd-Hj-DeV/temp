import 'package:equatable/equatable.dart';

/// الفئة الأساسية لحالات التحقق من OTP
abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class VerifyOtpInitial extends VerifyOtpState {}

/// حالة التحميل (جاري التحقق من الرمز)
class VerifyOtpLoading extends VerifyOtpState {}

/// حالة النجاح (رمز التحقق صحيح)
class VerifyOtpSuccess extends VerifyOtpState {
  final String message;

  const VerifyOtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// حالة الفشل (رمز التحقق خاطئ أو حدث خطأ)
class VerifyOtpFailure extends VerifyOtpState {
  final String error;

  const VerifyOtpFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
