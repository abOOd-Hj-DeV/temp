part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];
}

final class OtpInitial extends OtpState {
  const OtpInitial();
}

final class OtpVerifying extends OtpState {
  const OtpVerifying();
}

final class OtpResending extends OtpState {
  const OtpResending();
}

final class OtpVerified extends OtpState {
  final AuthSessionModel session;
  const OtpVerified(this.session);

  @override
  List<Object?> get props => [session];
}

final class OtpResent extends OtpState {
  final String message;
  const OtpResent(this.message);

  @override
  List<Object?> get props => [message];
}

final class OtpFailure extends OtpState {
  final String message;
  const OtpFailure(this.message);

  @override
  List<Object?> get props => [message];
}
