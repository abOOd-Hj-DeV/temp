import 'package:equatable/equatable.dart';

/// الفئة الأساسية شحالات تعيين كلمة المرور
abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class ResetPasswordInitial extends ResetPasswordState {}

/// حالة التحميل (جاري تحديث كلمة المرور)
class ResetPasswordLoading extends ResetPasswordState {}

/// حالة النجاح (تم تغيير كلمة المرور بنجاح)
class ResetPasswordSuccess extends ResetPasswordState {
  final String message;

  const ResetPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// حالة الفشل (حدث خطأ أثناء التغيير)
class ResetPasswordFailure extends ResetPasswordState {
  final String error;

  const ResetPasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
