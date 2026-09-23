import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etmaen/features/programs/data/models/program_model.dart';
import 'package:etmaen/features/programs/data/models/program_module_model.dart';
import 'package:etmaen/features/programs/data/repositories/program_repository.dart';

part 'program_state.dart';

class ProgramCubit extends Cubit<ProgramState> {
  final ProgramRepository repository;

  ProgramCubit(this.repository) : super(ProgramInitial());

  Future<void> getPrograms() async {
    emit(ProgramLoading());
    final result = await repository.getPrograms();
    result.fold(
      ifLeft: (failure) =>
          emit(ProgramError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (programs) => emit(ProgramsLoaded(programs)),
    );
  }

  Future<void> getModulesByProgram(String programId) async {
    emit(ProgramLoading());
    final result = await repository.getModulesByProgram(programId);
    result.fold(
      ifLeft: (failure) =>
          emit(ProgramError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (modules) => emit(ModulesLoaded(modules)),
    );
  }
}