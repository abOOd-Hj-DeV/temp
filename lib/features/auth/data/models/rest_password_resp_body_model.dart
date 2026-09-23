class ResetPasswordRespBodyModel {
  final String message;

  ResetPasswordRespBodyModel({
    required this.message,
  });

  factory ResetPasswordRespBodyModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRespBodyModel(
      message: json['message'] ?? '',
    );
  }
}
