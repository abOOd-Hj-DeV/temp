import 'package:etmaen/core/utils/functions.dart';

/// PocketBase therapists koleksiyonu modeli
class TherapistModel {
  final String id;
  final String name;
  final String fullName;
  final String title;
  final String specialty;
  final int reviewCount;
  final double rating;
  final int yearsOfExperience;
  final String country;
  final String city;
  final String district;
  final List<String> languages;
  final String? gender;
  final String? bio;
  final String? avatar;
  final bool isAvailable;
  final bool isEmergency;
  final int experienceYears;
  final String? imageUrl;
  final String created;
  final String updated;

  TherapistModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.title,
    required this.specialty,
    this.reviewCount = 0,
    this.rating = 0.0,
    required this.yearsOfExperience,
    required this.country,
    this.city = '',
    this.district = '',
    required this.languages,
    this.gender,
    this.bio,
    this.avatar,
    this.isAvailable = false,
    this.isEmergency = false,
    this.experienceYears = 0,
    this.imageUrl,
    this.created = '',
    this.updated = '',
  });

  factory TherapistModel.fromJson(Map<String, dynamic> json) {
    final languages = (json['languages'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    return TherapistModel(
      id: json['id'] ?? '',
      name: json['full_name'] ?? '',
      fullName: json['full_name'] ?? '',
      title: json['title'],
      specialty: json['specialty'] ?? '',
      reviewCount: json['review_count'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      yearsOfExperience: json['years_of_experience'] ?? 0,
      country: json['country'] ?? '',
      languages: languages,
      gender: json['gender'],
      bio: json['bio'],
      avatar: json['avatar'],
      isAvailable: json['is_available'] ?? false,
      isEmergency: json['is_emergency'] ?? false,
      experienceYears: json['years_of_experience'] ?? 0,
      imageUrl: json['avatar'] == ''
          ? null
          : getAvatarUrl(json['avatar'], json['id']),
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  factory TherapistModel.fromApi(Map<String, dynamic> json) {
    return TherapistModel.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'title': title,
      'specialty': specialty,
      'years_of_experience': yearsOfExperience,
      'country': country,
      'languages': languages,
      'gender': gender,
      'bio': bio,
      'avatar': avatar,
      'is_available': isAvailable,
      'is_emergency': isEmergency,
    };
  }

  static List<TherapistModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => TherapistModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
