import 'package:equatable/equatable.dart';

/// الفئة الأساسية لحالات نسيان كلمة المرور
abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class ForgotPasswordInitial extends ForgotPasswordState {}

/// حالة التحميل (جاري إرسال الطلب)
class ForgotPasswordLoading extends ForgotPasswordState {}

/// حالة النجاح (تم إرسال رابط/رمز الاستعادة)
class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;

  const ForgotPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// حالة الفشل (حدث خطأ أثناء الطلب)
class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;

  const ForgotPasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
