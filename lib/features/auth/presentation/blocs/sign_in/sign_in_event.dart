part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

final class SignInSubmitted extends SignInEvent {
  final String whatsappNumber;
  final String password;

  const SignInSubmitted({
    required this.whatsappNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [whatsappNumber, password];
}
