import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/models/patient_profile_model.dart';

class OnboardingStatusModel extends Equatable {
  final bool hasProfile;
  final PatientProfileModel? patient;
  final int profileCompletion;
  final List<String> nextSteps;

  const OnboardingStatusModel({
    required this.hasProfile,
    required this.patient,
    required this.profileCompletion,
    required this.nextSteps,
  });

  factory OnboardingStatusModel.fromJson(Map<String, dynamic> json) {
    final patient = json['patient'];
    return OnboardingStatusModel(
      hasProfile: json['has_profile'] == true,
      patient: patient is Map<String, dynamic>
          ? PatientProfileModel.fromJson(patient)
          : null,
      profileCompletion: (json['profile_completion'] as num?)?.toInt() ?? 0,
      nextSteps:
          (json['next_steps'] as List?)?.map((e) => e.toString()).toList() ??
              const [],
    );
  }

  @override
  List<Object?> get props =>
      [hasProfile, patient, profileCompletion, nextSteps];
}
