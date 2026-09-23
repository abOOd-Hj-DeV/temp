part of 'therapist_detail_bloc.dart';

sealed class TherapistDetailEvent extends Equatable {
  const TherapistDetailEvent();

  @override
  List<Object?> get props => [];
}

final class TherapistDetailRequested extends TherapistDetailEvent {
  final String id;
  const TherapistDetailRequested(this.id);

  @override
  List<Object?> get props => [id];
}
