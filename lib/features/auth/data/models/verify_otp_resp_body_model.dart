class VerifyOtpRespBodyModel {
  final bool success;
  final String message;

  VerifyOtpRespBodyModel({
    required this.success,
    required this.message,
  });

  factory VerifyOtpRespBodyModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRespBodyModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
