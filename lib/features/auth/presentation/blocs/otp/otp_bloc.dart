import 'package:equatable/equatable.dart';
import 'package:etmaen/features/auth/data/models/auth_session_model.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthRepository repository;

  OtpBloc(this.repository) : super(const OtpInitial()) {
    on<OtpSubmitted>(_onSubmitted);
    on<OtpResendRequested>(_onResend);
  }

  Future<void> _onSubmitted(OtpSubmitted event, Emitter<OtpState> emit) async {
    emit(const OtpVerifying());
    final result = await repository.verifyOtp(
      whatsappNumber: event.whatsappNumber,
      otp: event.otp,
    );
    result.fold(
      ifLeft: (failure) => emit(OtpFailure(failure.message)),
      ifRight: (session) => emit(OtpVerified(session)),
    );
  }

  Future<void> _onResend(
      OtpResendRequested event, Emitter<OtpState> emit) async {
    emit(const OtpResending());
    final result = await repository.resendOtp(event.whatsappNumber);
    result.fold(
      ifLeft: (failure) => emit(OtpFailure(failure.message)),
      ifRight: (message) => emit(OtpResent(message)),
    );
  }
}
