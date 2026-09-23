import 'package:equatable/equatable.dart';
import 'package:etmaen/features/auth/data/models/user_model.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_event.dart';
part 'session_state.dart';

/// حالة الجلسة على مستوى التطبيق (هل يوجد توكن صالح؟ من المستخدم؟)
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthRepository repository;

  SessionBloc(this.repository) : super(const SessionUnknown()) {
    on<SessionChecked>(_onChecked);
    on<SessionUserUpdated>(
        (event, emit) => emit(SessionAuthenticated(event.user)));
    on<SessionLogoutRequested>(_onLogout);
  }

  Future<void> _onChecked(
      SessionChecked event, Emitter<SessionState> emit) async {
    if (!await repository.isLoggedIn) {
      emit(const SessionUnauthenticated());
      return;
    }
    final result = await repository.currentUser();
    result.fold(
      ifLeft: (failure) {
        // 401 يعني أن التوكن مُلغى؛ غير ذلك (انقطاع شبكة) نبقي المستخدم داخلاً.
        if (failure.statusCode == 401) {
          emit(const SessionUnauthenticated());
        } else {
          emit(const SessionAuthenticated(null));
        }
      },
      ifRight: (user) => emit(SessionAuthenticated(user)),
    );
  }

  Future<void> _onLogout(
      SessionLogoutRequested event, Emitter<SessionState> emit) async {
    emit(const SessionLoggingOut());
    await repository.logout();
    emit(const SessionUnauthenticated());
  }
}
