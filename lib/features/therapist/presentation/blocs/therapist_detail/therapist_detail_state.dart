part of 'therapist_detail_cubit.dart';

sealed class TherapistDetailState extends Equatable {
  const TherapistDetailState();

  @override
  List<Object?> get props => [];
}

final class TherapistDetailInitial extends TherapistDetailState {
  const TherapistDetailInitial();
}

final class TherapistDetailLoading extends TherapistDetailState {
  const TherapistDetailLoading();
}

final class TherapistDetailLoaded extends TherapistDetailState {
  final TherapistModel therapist;
  final TherapistAvailabilityModel availability;
  final List<TherapistReviewModel> reviews;
  const TherapistDetailLoaded({
    required this.therapist,
    required this.availability,
    required this.reviews,
  });

  @override
  List<Object?> get props => [therapist, availability, reviews];
}

final class TherapistDetailError extends TherapistDetailState {
  final String message;
  const TherapistDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
