part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

final class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

final class SignUpSuccess extends SignUpState {
  final String message;
  final String whatsappNumber;
  const SignUpSuccess({required this.message, required this.whatsappNumber});

  @override
  List<Object?> get props => [message, whatsappNumber];
}

final class SignUpFailure extends SignUpState {
  final String message;
  const SignUpFailure(this.message);

  @override
  List<Object?> get props => [message];
}
