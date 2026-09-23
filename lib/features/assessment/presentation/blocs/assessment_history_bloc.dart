import 'package:equatable/equatable.dart';
import 'package:etmaen/features/assessment/data/models/assessment_result_model.dart';
import 'package:etmaen/features/assessment/data/repositories/assessment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assessment_history_event.dart';
part 'assessment_history_state.dart';

class AssessmentHistoryBloc
    extends Bloc<AssessmentHistoryEvent, AssessmentHistoryState> {
  final AssessmentRepository repository;

  AssessmentHistoryBloc(this.repository)
      : super(const AssessmentHistoryInitial()) {
    on<AssessmentHistoryRequested>(_onRequested);
  }

  Future<void> _onRequested(AssessmentHistoryRequested event,
      Emitter<AssessmentHistoryState> emit) async {
    emit(const AssessmentHistoryLoading());
    final result = await repository.history();
    result.fold(
      ifLeft: (failure) => emit(AssessmentHistoryFailure(failure.message)),
      ifRight: (history) => emit(AssessmentHistoryLoaded(history)),
    );
  }
}
