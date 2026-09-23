part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

/// الباك‑إند يرفض الطلب (422 `profile`) حتى يكمل المريض ملفه
final class DashboardProfileRequired extends DashboardState {
  const DashboardProfileRequired();
}

final class DashboardLoaded extends DashboardState {
  final DashboardModel dashboard;
  final ProgressModel? progress;
  const DashboardLoaded({required this.dashboard, this.progress});

  @override
  List<Object?> get props => [dashboard, progress];
}

final class DashboardFailure extends DashboardState {
  final String message;
  const DashboardFailure(this.message);

  @override
  List<Object?> get props => [message];
}
