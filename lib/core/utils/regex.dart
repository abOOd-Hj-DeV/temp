class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w\.\-+]+@[\w\-]+(\.[\w\-]+)+$').hasMatch(email);
  }

  /// يطابق قاعدة الباك‑إند: 8 أحرف على الأقل
  static bool isPasswordValid(String password) => password.length >= 8;

  /// يطابق قاعدة الباك‑إند: `^\+?[0-9]{8,15}$`
  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^\+?[0-9]{8,15}$').hasMatch(phoneNumber);
  }

  static bool isOtpValid(String otp) => RegExp(r'^[0-9]{6}$').hasMatch(otp);
}
