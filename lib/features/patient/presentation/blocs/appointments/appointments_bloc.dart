import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/models/appointments_model.dart';
import 'package:etmaen/features/patient/data/repositories/patient_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final PatientRepository repository;

  AppointmentsBloc(this.repository) : super(const AppointmentsInitial()) {
    on<AppointmentsRequested>(_onRequested);
  }

  Future<void> _onRequested(
      AppointmentsRequested event, Emitter<AppointmentsState> emit) async {
    emit(const AppointmentsLoading());
    final result = await repository.getAppointments();
    result.fold(
      ifLeft: (failure) => emit(failure.hasFieldError('profile')
          ? const AppointmentsProfileRequired()
          : AppointmentsFailure(failure.message)),
      ifRight: (appointments) => emit(AppointmentsLoaded(appointments)),
    );
  }
}
