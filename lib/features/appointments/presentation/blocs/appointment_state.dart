part of 'appointment_bloc.dart';

sealed class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

final class AppointmentInitial extends AppointmentState {
  const AppointmentInitial();
}

final class AppointmentLoading extends AppointmentState {
  const AppointmentLoading();
}

final class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;
  const AppointmentsLoaded(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

final class AppointmentCreated extends AppointmentState {
  final AppointmentModel appointment;
  const AppointmentCreated(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

final class AppointmentUpdated extends AppointmentState {
  final AppointmentModel appointment;
  const AppointmentUpdated(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

final class AppointmentCancelled extends AppointmentState {
  final AppointmentModel appointment;
  const AppointmentCancelled(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

final class AppointmentError extends AppointmentState {
  final String message;
  const AppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}