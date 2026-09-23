import 'package:equatable/equatable.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository repository;

  SignUpBloc(this.repository) : super(const SignUpInitial()) {
    on<SignUpSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(const SignUpLoading());
    final whatsapp = event.whatsappNumber.trim();
    final result = await repository.register(
      name: event.name.trim(),
      email: event.email.trim(),
      whatsappNumber: whatsapp,
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
    );
    result.fold(
      ifLeft: (failure) => emit(SignUpFailure(failure.message)),
      ifRight: (message) =>
          emit(SignUpSuccess(message: message, whatsappNumber: whatsapp)),
    );
  }
}
