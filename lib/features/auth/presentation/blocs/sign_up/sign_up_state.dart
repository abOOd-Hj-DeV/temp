import 'package:equatable/equatable.dart';

/// الفئة الأساسية لحالات إنشاء الحساب
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class SignUpInitial extends SignUpState {}

/// حالة التحميل (جاري إنشاء الحساب)
class SignUpLoading extends SignUpState {}

/// حالة النجاح (تم إنشاء الحساب بنجاح)
class SignUpSuccess extends SignUpState {
  final String message;

  const SignUpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// حالة الفشل (حدث خطأ أثناء الإنشاء)
class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
