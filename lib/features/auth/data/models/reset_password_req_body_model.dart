class ResetPasswordReqBodyModel {
  final String newPassword;

  ResetPasswordReqBodyModel({
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "newPassword": newPassword,
    };
  }
}
