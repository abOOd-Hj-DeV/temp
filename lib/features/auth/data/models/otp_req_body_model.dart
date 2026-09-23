class VerifyOtpReqBodyModel {
  final String otp;

  VerifyOtpReqBodyModel({
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
    };
  }
}
