/// فئة تحتوي على جميع نقاط النهاية (End Points) الخاصة بـ PocketBase API
class EndPoint {
  // الرابط الأساسي لـ PocketBase
  static String baseUrl =
      "http://127.0.0.1:8090/api/"; //https://pocketbase-production-0e71.up.railway.app/api/

  // === Auth Endpoints ===
  static String signIn = "collections/users/auth-with-password";
  static String signUp = "collections/users/records";
  static String requestPasswordReset =
      "collections/users/request-password-reset";
  static String confirmPasswordReset =
      "collections/users/confirm-password-reset";
  static String updateUserById(String id) => "collections/users/records/$id";
  static String verificationRequest = "collections/users/request-verification";
  static String verificationConfirm = "collections/users/confirm-verification";

  // === Collection Base Paths ===
  static const String _collections = "collections/";
  static const String _records = "/records";

  static String collection(String name) => "$_collections$name$_records";
  static String collectionById(String name, String id) =>
      "$_collections$name$_records/$id";

  // === Collection Base Paths ===
  static String appointments =
      "collections/appointments/records?expand=time_slot.slot,time_method";
  static String appointmentsById(String id) =>
      "collections/appointments/records/$id";
  static String assessments = "collections/assessment_templates/records";
  static String submitAssessments = "collections/user_assessments/records";
  static String assessmentsById(String id) =>
      "collections/assessments/records/$id";

  static String emergencyContacts = "collections/emergency_contacts/records";
  static String emergencyContactsById(String id) =>
      "collections/emergency_contacts/records/$id";

  static String faq = "collections/faq/records";
  static String faqById(String id) => "collections/faq/records/$id";

  static String messages = "collections/messages/records";
  static String messagesById(String id) => "collections/messages/records/$id";

  static String moodEntries = "collections/mood_entries/records";
  static String moodEntriesById(String id) =>
      "collections/mood_entries/records/$id";

  static String notifications = "collections/notifications/records";
  static String notificationsById(String id) =>
      "collections/notifications/records/$id";

  static String onboardingContent = "collections/onboarding_content/records";
  static String onboardingContentById(String id) =>
      "collections/onboarding_content/records/$id";

  static String payments = "collections/payments/records";
  static String paymentsById(String id) => "collections/payments/records/$id";

  static String programModules = "collections/program_modules/records";
  static String programModulesById(String id) =>
      "collections/program_modules/records/$id";

  static String programs = "collections/programs/records";
  static String programsById(String id) => "collections/programs/records/$id";

  static String supportTickets = "collections/support_tickets/records";
  static String supportTicketsById(String id) =>
      "collections/support_tickets/records/$id";

  static String therapistAvailability =
      "collections/therapist_availability/records";
  static String therapistAvailabilityById(String id) =>
      "collections/therapist_availability/records?filter=(therapist='$id')";

  //  "collections/therapist_availability/records/$id";

  static String therapistReviews = "collections/therapist_reviews/records";
  static String therapistReviewsById(String id) =>
      "collections/therapist_reviews/records?filter=(therapist='$id')";

  static String therapists = "collections/therapists/records";
  static String therapistsById(String id) =>
      "collections/therapists/records/$id";

  static String userPrograms = "collections/user_programs/records";
  static String userProgramsById(String id) =>
      "collections/user_programs/records/$id";

  static String userProgress = "collections/user_progress/records";
  static String userProgressById(String id) =>
      "collections/user_progress/records/$id";

  static String users = "collections/users/records";
  static String usersById(String id) => "collections/users/records/$id";

  static String weeklyStats = "collections/weekly_stats/records";
  static String weeklyStatsById(String id) =>
      "collections/weekly_stats/records/$id";

  static String getBookingDatesByTherapist() =>
      "collections/appointment_slots/records";

  static String getBookingTimesBySlot(String slotId) =>
      "collections/appointment_times/records";

  static String bookingAppointment = "collections/appointments/records";

  static String bookingApprove(String id) =>
      "collections/appointment_times/records/$id";

  static String getBookingMethods =
      "collections/appointment_time_methods/records";
}
