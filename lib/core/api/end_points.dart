/// مسارات الـ API الخاصة بالباك‑إند (Laravel) — النسخة v1.
///
/// الرابط الأساسي يُمرَّر وقت البناء:
/// `flutter run --dart-define=API_BASE_URL=https://api.example.com/api/v1/`
class EndPoint {
  EndPoint._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api/v1/',
  );

  // Auth
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String verifyOtp = 'auth/otp/verify';
  static const String resendOtp = 'auth/otp/resend';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';
  static const String authStatus = 'auth/status';
  static const String currentUser = 'auth/user';
  static const String logout = 'auth/logout';

  // Patients
  static const String profile = 'patients/profile';
  static const String onboarding = 'patients/onboarding';
  static const String dashboard = 'patients/dashboard';
  static const String progress = 'patients/progress';
  static const String appointments = 'patients/appointments';
  static const String programs = 'patients/programs';
  static const String deleteAccount = 'patients/account';
  static const String exportData = 'patients/export-data';

  // Assessment
  static const String assessment = 'patients/assessment';
  static const String assessmentHistory = 'patients/assessment/history';
}
