import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/models/patient_profile_model.dart';
import 'package:etmaen/features/patient/data/repositories/patient_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PatientRepository repository;

  ProfileBloc(this.repository) : super(const ProfileInitial()) {
    on<ProfileRequested>(_onRequested);
    on<ProfileSaveRequested>(_onSave);
  }

  Future<void> _onRequested(
      ProfileRequested event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    final result = await repository.getProfile();
    result.fold(
      ifLeft: (failure) => emit(ProfileFailure(failure.message)),
      ifRight: (profile) => emit(
          profile == null ? const ProfileMissing() : ProfileLoaded(profile)),
    );
  }

  Future<void> _onSave(
      ProfileSaveRequested event, Emitter<ProfileState> emit) async {
    final previous = state;
    emit(ProfileSaving(
        current: previous is ProfileLoaded ? previous.profile : null));
    final result = await repository.updateProfile(
      fullName: event.fullName.trim(),
      age: event.age,
      gender: event.gender,
      language: event.language,
    );
    result.fold(
      ifLeft: (failure) {
        emit(ProfileFailure(failure.message));
        if (previous is ProfileLoaded) emit(previous);
      },
      ifRight: (profile) {
        emit(ProfileSaved(profile));
        emit(ProfileLoaded(profile));
      },
    );
  }
}
