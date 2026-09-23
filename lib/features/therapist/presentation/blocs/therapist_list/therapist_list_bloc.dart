import 'package:equatable/equatable.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/features/therapist/data/repositories/therapist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'therapist_list_event.dart';
part 'therapist_list_state.dart';

class TherapistListBloc extends Bloc<TherapistListEvent, TherapistListState> {
  final TherapistRepository repository;

  TherapistListBloc(this.repository) : super(const TherapistListInitial()) {
    on<TherapistListRequested>(_onRequested);
  }

  Future<void> _onRequested(
      TherapistListRequested event, Emitter<TherapistListState> emit) async {
    emit(const TherapistListLoading());
    final result = await repository.getTherapists();
    result.fold(
      ifLeft: (failure) =>
          emit(TherapistListError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (therapists) => emit(TherapistListLoaded(therapists)),
    );
  }
}
