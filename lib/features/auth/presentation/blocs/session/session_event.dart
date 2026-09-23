part of 'session_bloc.dart';

sealed class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object?> get props => [];
}

final class SessionChecked extends SessionEvent {
  const SessionChecked();
}

final class SessionUserUpdated extends SessionEvent {
  final UserModel user;
  const SessionUserUpdated(this.user);

  @override
  List<Object?> get props => [user];
}

final class SessionLogoutRequested extends SessionEvent {
  const SessionLogoutRequested();
}
