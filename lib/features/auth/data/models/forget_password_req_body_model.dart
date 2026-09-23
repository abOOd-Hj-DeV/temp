class ForgetPasswordReqBodyModel {
  final String email;

  ForgetPasswordReqBodyModel({required this.email});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}
