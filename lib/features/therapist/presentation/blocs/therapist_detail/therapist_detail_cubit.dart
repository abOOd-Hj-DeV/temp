import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/features/therapist/data/models/therapist_availability_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_review_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/features/therapist/data/repositories/therapist_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'therapist_detail_state.dart';

class TherapistDetailCubit extends Cubit<TherapistDetailState> {
  final TherapistRepository repository;

  TherapistDetailCubit(this.repository) : super(const TherapistDetailInitial());

  void navigateToBookingPage(TherapistModel therapist) {
    Modular.to.pushNamed(
      AppRouteName.bookingPage,
      arguments: therapist,
    );
  }

  Future<void> getTherapistDetail(String id) async {
    emit(const TherapistDetailLoading());

    final results = await Future.wait([
      repository.getTherapistById(id),
      repository.getTherapistsReviews(id),
      repository.getTherapistsAvailability(id),
    ]);

    final therapistResult = results[0] as Either<Failure, TherapistModel>;
    final reviewsResult =
        results[1] as Either<Failure, List<TherapistReviewModel>>;
    final availabilityResult =
        results[2] as Either<Failure, TherapistAvailabilityModel>;

    final errors = <String>[];
    TherapistModel? therapist;
    List<TherapistReviewModel>? reviews;
    TherapistAvailabilityModel? availability;

    therapistResult.fold(
      ifLeft: (error) => errors.add(error.errorMessage ?? 'Unknown error'),
      ifRight: (value) => therapist = value,
    );
    reviewsResult.fold(
      ifLeft: (error) => errors.add(error.errorMessage ?? 'Unknown error'),
      ifRight: (value) => reviews = value,
    );

    availabilityResult.fold(
        ifLeft: (value) => errors.add(value.errorMessage ?? 'Unknown error'),
        ifRight: (value) => availability = value);

    if (errors.isNotEmpty) {
      emit(TherapistDetailError(errors.join('\n')));
      return;
    }

    emit(TherapistDetailLoaded(
      therapist: therapist ??
          TherapistModel(
            // 1
            id: '1',
            name: '',
            fullName: '',
            specialty: '',
            yearsOfExperience: 8,
            country: '',
            languages: [],
            title: '',
          ),
      availability: availability ??
          const TherapistAvailabilityModel(
            id: '',
            availabilityTime: {},
          ),
      reviews: reviews ?? [],
    ));
  }
}
