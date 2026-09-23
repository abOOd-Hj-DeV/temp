part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

final class OtpSubmitted extends OtpEvent {
  final String whatsappNumber;
  final String otp;
  const OtpSubmitted({required this.whatsappNumber, required this.otp});

  @override
  List<Object?> get props => [whatsappNumber, otp];
}

final class OtpResendRequested extends OtpEvent {
  final String whatsappNumber;
  const OtpResendRequested(this.whatsappNumber);

  @override
  List<Object?> get props => [whatsappNumber];
}
