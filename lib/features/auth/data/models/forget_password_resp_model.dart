class ForgetPasswordRespBodyModel {
  final String message;

  ForgetPasswordRespBodyModel({
    required this.message,
  });

  factory ForgetPasswordRespBodyModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordRespBodyModel(
      message: json['message'] ?? '',
    );
  }
}
