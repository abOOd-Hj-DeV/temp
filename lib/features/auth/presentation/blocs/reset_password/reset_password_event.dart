part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

final class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String whatsappNumber;
  final String otp;
  final String password;
  final String passwordConfirmation;

  const ResetPasswordSubmitted({
    required this.whatsappNumber,
    required this.otp,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props =>
      [whatsappNumber, otp, password, passwordConfirmation];
}
