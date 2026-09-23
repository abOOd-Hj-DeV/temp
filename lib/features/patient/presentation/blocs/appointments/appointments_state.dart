part of 'appointments_bloc.dart';

sealed class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object?> get props => [];
}

final class AppointmentsInitial extends AppointmentsState {
  const AppointmentsInitial();
}

final class AppointmentsLoading extends AppointmentsState {
  const AppointmentsLoading();
}

final class AppointmentsProfileRequired extends AppointmentsState {
  const AppointmentsProfileRequired();
}

final class AppointmentsLoaded extends AppointmentsState {
  final AppointmentsModel appointments;
  const AppointmentsLoaded(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

final class AppointmentsFailure extends AppointmentsState {
  final String message;
  const AppointmentsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
