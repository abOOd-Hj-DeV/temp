import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/features/therapist/data/repositories/therapist_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'therapist_list_state.dart';

class TherapistListCubit extends Cubit<TherapistListState> {
  final TherapistRepository repository;

  TherapistListCubit(this.repository) : super(const TherapistListInitial());

  void getTherapistById(String id) {
    Modular.to.pushNamed(
      AppRouteName.doctorProfileDetails,
      arguments: id,
    );
  }

  void navigateToBookingPage(TherapistModel therapist) {
    Modular.to.pushNamed(AppRouteName.bookingPage, arguments: therapist);
  }

  Future<void> getTherapists({
    Map<String, dynamic>? queryParameters,
  }) async {
    emit(const TherapistListLoading());
    final result = await repository.getTherapists();
    result.fold(
      ifLeft: (failure) =>
          emit(TherapistListError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (therapists) => emit(TherapistListLoaded(therapists)),
    );
  }
}
