part of 'therapist_list_cubit.dart';

sealed class TherapistListState extends Equatable {
  const TherapistListState();

  @override
  List<Object?> get props => [];
}

final class TherapistListInitial extends TherapistListState {
  const TherapistListInitial();
}

final class TherapistListLoading extends TherapistListState {
  const TherapistListLoading();
}

final class TherapistListLoaded extends TherapistListState {
  final List<TherapistModel> therapists;
  const TherapistListLoaded(this.therapists);

  @override
  List<Object?> get props => [therapists];
}

final class TherapistListError extends TherapistListState {
  final String message;
  const TherapistListError(this.message);

  @override
  List<Object?> get props => [message];
}
