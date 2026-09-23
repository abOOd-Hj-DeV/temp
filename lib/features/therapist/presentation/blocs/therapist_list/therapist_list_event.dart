part of 'therapist_list_bloc.dart';

sealed class TherapistListEvent extends Equatable {
  const TherapistListEvent();

  @override
  List<Object?> get props => [];
}

final class TherapistListRequested extends TherapistListEvent {
  const TherapistListRequested();
}
