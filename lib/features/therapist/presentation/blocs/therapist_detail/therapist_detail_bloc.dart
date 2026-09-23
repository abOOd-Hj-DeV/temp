import 'package:equatable/equatable.dart';
import 'package:etmaen/features/therapist/data/models/therapist_availability_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_review_model.dart';
import 'package:etmaen/features/therapist/data/repositories/therapist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'therapist_detail_event.dart';
part 'therapist_detail_state.dart';

class TherapistDetailBloc
    extends Bloc<TherapistDetailEvent, TherapistDetailState> {
  final TherapistRepository repository;

  TherapistDetailBloc(this.repository) : super(const TherapistDetailInitial()) {
    on<TherapistDetailRequested>(_onRequested);
  }

  Future<void> _onRequested(TherapistDetailRequested event,
      Emitter<TherapistDetailState> emit) async {
    emit(const TherapistDetailLoading());

    final (therapistResult, reviewsResult, availabilityResult) = await (
      repository.getTherapistById(event.id),
      repository.getTherapistsReviews(event.id),
      repository.getTherapistsAvailability(event.id),
    ).wait;

    final errors = <String>[];
    TherapistModel? therapist;
    List<TherapistReviewModel>? reviews;
    TherapistAvailabilityModel? availability;

    therapistResult.fold(
      ifLeft: (f) => errors.add(f.errorMessage ?? 'Unknown error'),
      ifRight: (v) => therapist = v,
    );
    reviewsResult.fold(
      ifLeft: (f) => errors.add(f.errorMessage ?? 'Unknown error'),
      ifRight: (v) => reviews = v,
    );
    availabilityResult.fold(
      ifLeft: (f) => errors.add(f.errorMessage ?? 'Unknown error'),
      ifRight: (v) => availability = v,
    );

    final loadedTherapist = therapist;
    if (errors.isNotEmpty || loadedTherapist == null) {
      emit(TherapistDetailError(errors.join('\n')));
      return;
    }

    emit(TherapistDetailLoaded(
      therapist: loadedTherapist,
      availability: availability ??
          const TherapistAvailabilityModel(id: '', availabilityTime: {}),
      reviews: reviews ?? const [],
    ));
  }
}
