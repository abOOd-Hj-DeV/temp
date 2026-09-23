import 'package:equatable/equatable.dart';

class PatientProfileModel extends Equatable {
  final String userId;
  final String fullName;
  final int? age;
  final String gender;
  final String language;
  final String complianceLevel;
  final bool hasTherapist;
  final bool hasSubscription;

  const PatientProfileModel({
    required this.userId,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.language,
    required this.complianceLevel,
    required this.hasTherapist,
    required this.hasSubscription,
  });

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) {
    return PatientProfileModel(
      userId: json['user_id']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      age: json['age'] is int ? json['age'] : int.tryParse('${json['age']}'),
      gender: json['gender']?.toString() ?? '',
      language: json['language']?.toString() ?? 'ar',
      complianceLevel: json['compliance_level']?.toString() ?? '',
      hasTherapist: json['has_therapist'] == true,
      hasSubscription: json['has_subscription'] == true,
    );
  }

  String get genderLabel => switch (gender) {
        'male' => 'ذكر',
        'female' => 'أنثى',
        'other' => 'آخر',
        _ => '-',
      };

  String get languageLabel => language == 'en' ? 'English' : 'العربية';

  @override
  List<Object?> get props => [
        userId,
        fullName,
        age,
        gender,
        language,
        complianceLevel,
        hasTherapist,
        hasSubscription,
      ];
}
