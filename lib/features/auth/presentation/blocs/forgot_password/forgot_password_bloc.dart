import 'package:equatable/equatable.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository repository;

  ForgotPasswordBloc(this.repository) : super(const ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    emit(const ForgotPasswordLoading());
    final whatsapp = event.whatsappNumber.trim();
    final result = await repository.forgotPassword(whatsapp);
    result.fold(
      ifLeft: (failure) => emit(ForgotPasswordFailure(failure.message)),
      ifRight: (message) => emit(
          ForgotPasswordSuccess(message: message, whatsappNumber: whatsapp)),
    );
  }
}
