part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileRequested extends ProfileEvent {
  const ProfileRequested();
}

final class ProfileSaveRequested extends ProfileEvent {
  final String fullName;
  final int age;
  final String gender;
  final String language;

  const ProfileSaveRequested({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.language,
  });

  @override
  List<Object?> get props => [fullName, age, gender, language];
}
