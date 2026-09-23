part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

final class AccountInitial extends AccountState {
  const AccountInitial();
}

final class AccountBusy extends AccountState {
  const AccountBusy();
}

final class AccountDeleted extends AccountState {
  final String message;
  const AccountDeleted(this.message);

  @override
  List<Object?> get props => [message];
}

final class AccountExported extends AccountState {
  final Map<String, dynamic> data;
  const AccountExported(this.data);

  @override
  List<Object?> get props => [data];
}

final class AccountFailure extends AccountState {
  final String message;
  const AccountFailure(this.message);

  @override
  List<Object?> get props => [message];
}
