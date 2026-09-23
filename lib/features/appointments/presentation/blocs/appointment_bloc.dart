import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etmaen/features/appointments/data/models/appointment_model.dart';
import 'package:etmaen/features/appointments/data/repositories/appointment_repository.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository repository;

  AppointmentBloc(this.repository) : super(const AppointmentInitial()) {
    on<GetAppointments>(_onGetAppointments);
    on<CreateAppointment>(_onCreateAppointment);
    on<UpdateAppointment>(_onUpdateAppointment);
    on<CancelAppointment>(_onCancelAppointment);
  }

  Future<void> _onGetAppointments(
    GetAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());
    final result = await repository.getAppointments(
      queryParameters: event.queryParameters,
    );
    result.fold(
      ifLeft: (failure) =>
          emit(AppointmentError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (appointments) => emit(AppointmentsLoaded(appointments)),
    );
  }

  Future<void> _onCreateAppointment(
    CreateAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());
    final result = await repository.createAppointment(event.data);
    result.fold(
      ifLeft: (failure) =>
          emit(AppointmentError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (appointment) => emit(AppointmentCreated(appointment)),
    );
  }

  Future<void> _onUpdateAppointment(
    UpdateAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());
    final result = await repository.updateAppointment(event.id, event.data);
    result.fold(
      ifLeft: (failure) =>
          emit(AppointmentError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (appointment) => emit(AppointmentUpdated(appointment)),
    );
  }

  Future<void> _onCancelAppointment(
    CancelAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());
    final result = await repository.updateAppointment(
      event.id,
      {'status': 'cancelled'},
    );
    result.fold(
      ifLeft: (failure) =>
          emit(AppointmentError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (appointment) => emit(AppointmentCancelled(appointment)),
    );
  }
}