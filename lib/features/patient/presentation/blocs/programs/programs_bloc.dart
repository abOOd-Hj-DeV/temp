import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/models/program_model.dart';
import 'package:etmaen/features/patient/data/repositories/patient_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  final PatientRepository repository;

  ProgramsBloc(this.repository) : super(const ProgramsInitial()) {
    on<ProgramsRequested>(_onRequested);
  }

  Future<void> _onRequested(
      ProgramsRequested event, Emitter<ProgramsState> emit) async {
    emit(const ProgramsLoading());
    final result = await repository.getPrograms();
    result.fold(
      ifLeft: (failure) => emit(ProgramsFailure(failure.message)),
      ifRight: (programs) => emit(ProgramsLoaded(programs)),
    );
  }
}
