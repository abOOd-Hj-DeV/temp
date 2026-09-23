part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

final class SignUpSubmitted extends SignUpEvent {
  final String name;
  final String email;
  final String whatsappNumber;
  final String password;
  final String passwordConfirmation;

  const SignUpSubmitted({
    required this.name,
    required this.email,
    required this.whatsappNumber,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props =>
      [name, email, whatsappNumber, password, passwordConfirmation];
}
