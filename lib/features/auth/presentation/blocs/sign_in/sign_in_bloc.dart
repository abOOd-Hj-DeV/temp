import 'package:equatable/equatable.dart';
import 'package:etmaen/features/auth/data/models/auth_session_model.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository repository;

  SignInBloc(this.repository) : super(const SignInInitial()) {
    on<SignInSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    emit(const SignInLoading());
    final result = await repository.login(
      whatsappNumber: event.whatsappNumber.trim(),
      password: event.password,
    );
    result.fold(
      ifLeft: (failure) => emit(SignInFailure(failure.message)),
      ifRight: (session) => emit(SignInSuccess(session)),
    );
  }
}
