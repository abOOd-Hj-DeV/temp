/// PocketBase users koleksiyonu modeli
class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final int? age;
  final String? gender;
  final String? dateOfBirth;
  final String? avatar;
  final bool emailVisibility;
  final bool verified;
  final String created;
  final String updated;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.age,
    this.gender,
    this.dateOfBirth,
    this.avatar,
    this.emailVisibility = false,
    this.verified = false,
    required this.created,
    required this.updated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      phone: json['phone'],
      age: json['age'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      avatar: json['avatar'],
      emailVisibility: json['emailVisibility'] ?? false,
      verified: json['verified'] ?? false,
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'age': age,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'avatar': avatar,
      'emailVisibility': emailVisibility,
      'verified': verified,
      'created': created,
      'updated': updated,
    };
  }
}