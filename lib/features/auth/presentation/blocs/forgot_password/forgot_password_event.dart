part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

final class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String whatsappNumber;
  const ForgotPasswordSubmitted(this.whatsappNumber);

  @override
  List<Object?> get props => [whatsappNumber];
}
