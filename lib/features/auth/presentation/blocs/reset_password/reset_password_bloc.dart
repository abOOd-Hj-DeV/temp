import 'package:equatable/equatable.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepository repository;

  ResetPasswordBloc(this.repository) : super(const ResetPasswordInitial()) {
    on<ResetPasswordSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      ResetPasswordSubmitted event, Emitter<ResetPasswordState> emit) async {
    emit(const ResetPasswordLoading());
    final result = await repository.resetPassword(
      whatsappNumber: event.whatsappNumber,
      otp: event.otp,
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
    );
    result.fold(
      ifLeft: (failure) => emit(ResetPasswordFailure(failure.message)),
      ifRight: (message) => emit(ResetPasswordSuccess(message)),
    );
  }
}
