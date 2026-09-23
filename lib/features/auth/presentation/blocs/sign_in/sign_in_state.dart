import 'package:equatable/equatable.dart';

/// الفئة الأساسية لحالات تسجيل الدخول
abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class SignInInitial extends SignInState {}

/// حالة التحميل (جاري تسجيل الدخول)
class SignInLoading extends SignInState {}

/// حالة النجاح (تم تسجيل الدخول بنجاح)
class SignInSuccess extends SignInState {
  final String message;

  const SignInSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// حالة الفشل (حدث خطأ أثناء تسجيل الدخول)
class SignInFailure extends SignInState {
  final String error;

  const SignInFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
