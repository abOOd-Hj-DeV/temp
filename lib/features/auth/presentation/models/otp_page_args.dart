enum OtpPurpose { register, resetPassword }

/// وسائط صفحة OTP: الرقم الذي أُرسل إليه الرمز والغرض منه
class OtpPageArgs {
  final String whatsappNumber;
  final OtpPurpose purpose;

  const OtpPageArgs({required this.whatsappNumber, required this.purpose});
}

/// وسائط صفحة تعيين كلمة سر جديدة
class ResetPasswordArgs {
  final String whatsappNumber;
  final String otp;

  const ResetPasswordArgs({required this.whatsappNumber, required this.otp});
}
