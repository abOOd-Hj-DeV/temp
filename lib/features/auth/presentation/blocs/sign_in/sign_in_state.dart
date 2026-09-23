part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

final class SignInInitial extends SignInState {
  const SignInInitial();
}

final class SignInLoading extends SignInState {
  const SignInLoading();
}

final class SignInSuccess extends SignInState {
  final AuthSessionModel session;
  const SignInSuccess(this.session);

  @override
  List<Object?> get props => [session];
}

final class SignInFailure extends SignInState {
  final String message;
  const SignInFailure(this.message);

  @override
  List<Object?> get props => [message];
}
