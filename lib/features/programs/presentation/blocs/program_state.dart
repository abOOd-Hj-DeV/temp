part of 'program_cubit.dart';

sealed class ProgramState extends Equatable {
  const ProgramState();

  @override
  List<Object?> get props => [];
}

final class ProgramInitial extends ProgramState {
  const ProgramInitial();
}

final class ProgramLoading extends ProgramState {
  const ProgramLoading();
}

final class ProgramsLoaded extends ProgramState {
  final List<ProgramModel> programs;
  const ProgramsLoaded(this.programs);

  @override
  List<Object?> get props => [programs];
}

final class ModulesLoaded extends ProgramState {
  final List<ProgramModuleModel> modules;
  const ModulesLoaded(this.modules);

  @override
  List<Object?> get props => [modules];
}

final class ProgramError extends ProgramState {
  final String message;
  const ProgramError(this.message);

  @override
  List<Object?> get props => [message];
}