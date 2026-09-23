import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/models/patient_profile_model.dart';

/// المستخدم كما يعيده Laravel (`users` + علاقة `patient`)
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String whatsappNumber;
  final bool isActive;
  final bool isVerified;
  final PatientProfileModel? patient;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.whatsappNumber,
    required this.isActive,
    required this.isVerified,
    this.patient,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final patientJson = json['patient'];
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      whatsappNumber: json['whatsapp_number']?.toString() ?? '',
      isActive: json['is_active'] == true || json['is_active'] == 1,
      isVerified: json['phone_verified_at'] != null,
      patient: patientJson is Map<String, dynamic>
          ? PatientProfileModel.fromJson(patientJson)
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, email, whatsappNumber, isActive, isVerified, patient];
}
