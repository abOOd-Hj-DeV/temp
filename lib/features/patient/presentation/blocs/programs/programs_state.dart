part of 'programs_bloc.dart';

sealed class ProgramsState extends Equatable {
  const ProgramsState();

  @override
  List<Object?> get props => [];
}

final class ProgramsInitial extends ProgramsState {
  const ProgramsInitial();
}

final class ProgramsLoading extends ProgramsState {
  const ProgramsLoading();
}

final class ProgramsLoaded extends ProgramsState {
  final List<ProgramModel> programs;
  const ProgramsLoaded(this.programs);

  @override
  List<Object?> get props => [programs];
}

final class ProgramsFailure extends ProgramsState {
  final String message;
  const ProgramsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
