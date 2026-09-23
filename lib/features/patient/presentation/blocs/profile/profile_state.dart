part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// المستخدم مسجّل لكنه لم يُنشئ ملف المريض بعد
final class ProfileMissing extends ProfileState {
  const ProfileMissing();
}

final class ProfileLoaded extends ProfileState {
  final PatientProfileModel profile;
  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class ProfileSaving extends ProfileState {
  final PatientProfileModel? current;
  const ProfileSaving({this.current});

  @override
  List<Object?> get props => [current];
}

final class ProfileSaved extends ProfileState {
  final PatientProfileModel profile;
  const ProfileSaved(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class ProfileFailure extends ProfileState {
  final String message;
  const ProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}
