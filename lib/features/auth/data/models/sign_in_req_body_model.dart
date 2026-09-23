/// PocketBase giriş isteği: { identity, password }
class SignInReqBodyModel {
  final String identity;
  final String password;

  SignInReqBodyModel({
    required this.identity,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'identity': identity,
      'password': password,
    };
  }
}