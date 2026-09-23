part of 'appointment_bloc.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

final class GetAppointments extends AppointmentEvent {
  final Map<String, dynamic>? queryParameters;
  const GetAppointments({this.queryParameters});

  @override
  List<Object?> get props => [queryParameters];
}

final class CreateAppointment extends AppointmentEvent {
  final Map<String, dynamic> data;
  const CreateAppointment(this.data);

  @override
  List<Object?> get props => [data];
}

final class UpdateAppointment extends AppointmentEvent {
  final String id;
  final Map<String, dynamic> data;
  const UpdateAppointment(this.id, this.data);

  @override
  List<Object?> get props => [id, data];
}

final class CancelAppointment extends AppointmentEvent {
  final String id;
  const CancelAppointment(this.id);

  @override
  List<Object?> get props => [id];
}