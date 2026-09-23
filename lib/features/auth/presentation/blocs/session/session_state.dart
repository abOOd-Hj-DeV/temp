part of 'session_bloc.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

final class SessionUnknown extends SessionState {
  const SessionUnknown();
}

final class SessionAuthenticated extends SessionState {
  /// قد يكون null عند تعذر جلب المستخدم مع وجود توكن صالح
  final UserModel? user;
  const SessionAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

final class SessionLoggingOut extends SessionState {
  const SessionLoggingOut();
}

final class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}
