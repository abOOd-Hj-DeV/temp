/// PocketBase kayıt isteği: email, password, passwordConfirm + opsiyonel alanlar
class SignupReqBodyModel {
  final String email;
  final String password;
  final String passwordConfirm;
  final String? name;
  final String? phone;
  final int? age;
  final String? gender;

  SignupReqBodyModel({
    required this.email,
    required this.password,
    required this.passwordConfirm,
    this.name,
    this.phone,
    this.age,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
    };
  }
}