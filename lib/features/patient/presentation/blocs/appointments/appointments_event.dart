part of 'appointments_bloc.dart';

sealed class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();

  @override
  List<Object?> get props => [];
}

final class AppointmentsRequested extends AppointmentsEvent {
  const AppointmentsRequested();
}
