import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/models/dashboard_model.dart';
import 'package:etmaen/features/patient/data/models/progress_model.dart';
import 'package:etmaen/features/patient/data/repositories/patient_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final PatientRepository repository;

  DashboardBloc(this.repository) : super(const DashboardInitial()) {
    on<DashboardRequested>(_onRequested);
  }

  Future<void> _onRequested(
      DashboardRequested event, Emitter<DashboardState> emit) async {
    emit(const DashboardLoading());
    final dashboardResult = await repository.getDashboard();
    await dashboardResult.fold(
      ifLeft: (failure) async {
        if (failure.hasFieldError('profile')) {
          emit(const DashboardProfileRequired());
        } else {
          emit(DashboardFailure(failure.message));
        }
      },
      ifRight: (dashboard) async {
        final progressResult = await repository.getProgress();
        emit(DashboardLoaded(
          dashboard: dashboard,
          progress: progressResult.fold(
            ifLeft: (_) => null,
            ifRight: (p) => p,
          ),
        ));
      },
    );
  }
}
