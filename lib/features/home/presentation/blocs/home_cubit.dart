import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etmaen/features/home/data/models/weekly_stats_model.dart';
import 'package:etmaen/features/home/data/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> getWeeklyStats(String userId) async {
    emit(HomeLoading());
    final result = await repository.getWeeklyStats(userId);
    result.fold(
      ifLeft: (failure) =>
          emit(HomeError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (stats) => emit(HomeLoaded(stats)),
    );
  }
}