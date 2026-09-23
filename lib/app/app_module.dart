import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/utils/page_transitions.dart';
import 'package:etmaen/features/assessment/data/models/assessment_result_model.dart';
import 'package:etmaen/features/assessment/data/models/assessment_type.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_bloc.dart';
import 'package:etmaen/features/assessment/presentation/screens/assessment_history_screen.dart';
import 'package:etmaen/features/assessment/presentation/screens/assessment_intro_screen.dart';
import 'package:etmaen/features/assessment/presentation/screens/assessment_question_screen.dart';
import 'package:etmaen/features/assessment/presentation/screens/assessment_result_screen.dart';
import 'package:etmaen/features/auth/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/otp/otp_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/reset_password/reset_password_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:etmaen/features/auth/presentation/models/otp_page_args.dart';
import 'package:etmaen/features/auth/presentation/pages/create_account_page.dart';
import 'package:etmaen/features/auth/presentation/pages/create_new_password_page.dart';
import 'package:etmaen/features/auth/presentation/pages/enter_otp_page.dart';
import 'package:etmaen/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:etmaen/features/auth/presentation/pages/sign_in_page.dart';
import 'package:etmaen/features/booking/presentation/blocs/booking_bloc.dart';
import 'package:etmaen/features/booking/presentation/screens/booking_page.dart';
import 'package:etmaen/features/emergency/presentation/pages/emergency_page.dart';
import 'package:etmaen/features/faq/presentation/pages/faq_page.dart';
import 'package:etmaen/features/introduction/presentation/page/onboarding_page.dart';
import 'package:etmaen/features/introduction/presentation/page/splash_page.dart';
import 'package:etmaen/features/introduction/presentation/page/start_video.dart';
import 'package:etmaen/features/introduction/presentation/page/welcome_page.dart';
import 'package:etmaen/features/legal/presentation/pages/legal_page.dart';
import 'package:etmaen/features/patient/presentation/pages/complete_profile_page.dart';
import 'package:etmaen/features/payment/presentation/models/package_model.dart';
import 'package:etmaen/features/payment/presentation/pages/packages_page.dart';
import 'package:etmaen/features/payment/presentation/pages/payment_summary_page.dart';
import 'package:etmaen/features/payment/presentation/pages/thank_you_page.dart';
import 'package:etmaen/features/profile/presentation/pages/help_and_support_page.dart';
import 'package:etmaen/features/profile/presentation/pages/personal_info_page.dart';
import 'package:etmaen/features/profile/presentation/pages/profile_page.dart';
import 'package:etmaen/features/programs/presentation/pages/programs_page.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_detail/therapist_detail_bloc.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_list/therapist_list_bloc.dart';
import 'package:etmaen/features/therapist/presentation/pages/therapist_list_page.dart';
import 'package:etmaen/features/therapist/presentation/pages/therapist_profile_details_page.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:etmaen/shared/widget/core_page.dart';
import 'package:etmaen/shared/widget/missing_arguments_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  /// يبني الصفحة فقط إذا كانت arguments من النوع المتوقع، وإلا يعرض صفحة خطأ واضحة
  static Widget _withArgs<T>(Widget Function(T args) builder) {
    final data = Modular.args.data;
    return data is T ? builder(data) : const MissingArgumentsPage();
  }

  @override
  void routes(RouteManager r) {
    // ---------- Introduction ----------
    r.child(AppRouteName.splash,
        child: (_) => const SplashPage(), transition: TransitionType.fadeIn);
    r.child(AppRouteName.onboarding,
        child: (_) => const OnboardingPage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.welcome,
        child: (_) => const WelcomePage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.startVideo,
        child: (_) => const StartVideo(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);

    // ---------- Auth ----------
    r.child(AppRouteName.createAccount,
        child: (_) => BlocProvider(
              create: (_) => sl<SignUpBloc>(),
              child: const CreateAccountScreen(),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.signIn,
        child: (_) => BlocProvider(
              create: (_) => sl<SignInBloc>(),
              child: const SignInPage(),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.enterOtp,
        child: (_) => _withArgs<OtpPageArgs>(
              (args) => BlocProvider(
                create: (_) => sl<OtpBloc>(),
                child: EnterOtpPage(args: args),
              ),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.forgotPassword,
        child: (_) => BlocProvider(
              create: (_) => sl<ForgotPasswordBloc>(),
              child: const ForgotPasswordPage(),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.createNewPassword,
        child: (_) => _withArgs<ResetPasswordArgs>(
              (args) => BlocProvider(
                create: (_) => sl<ResetPasswordBloc>(),
                child: CreateNewPasswordPage(args: args),
              ),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);

    // ---------- Core / Patient ----------
    r.child(AppRouteName.home,
        child: (_) => const CorePage(), transition: TransitionType.fadeIn);
    r.child(AppRouteName.completeProfile,
        child: (_) => const CompleteProfilePage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideUp);
    r.child(AppRouteName.profile,
        child: (_) => const ProfilePage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.editPersonalInfo,
        child: (_) => const EditPersonalInfoPage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideUp);
    r.child(AppRouteName.programs,
        child: (_) => const ProgramsPage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.helpAndSupport,
        child: (_) => const HelpAndSupportPage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.faq,
        child: (_) => const FaqPage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.emergency,
        child: (_) => const EmergencyPage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideUp);
    r.child(AppRouteName.privacyPolicy,
        child: (_) => const LegalPage(document: LegalDocument.privacyPolicy),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.termsAndConditions,
        child: (_) =>
            const LegalPage(document: LegalDocument.termsAndConditions),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);

    // ---------- Assessment ----------
    r.child(AppRouteName.assessmentIntroScreen,
        child: (_) => const AssessmentIntroScreen(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.assessmentQuestionScreen, child: (_) {
      final type = Modular.args.data;
      final resolved = type is AssessmentType ? type : AssessmentType.phq9;
      return BlocProvider(
        create: (_) => sl<AssessmentBloc>()..add(AssessmentStarted(resolved)),
        child: AssessmentQuestionScreen(type: resolved),
      );
    },
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.assessmentResultScreen,
        child: (_) => _withArgs<AssessmentResultModel>(
              (result) => AssessmentResultScreen(result: result),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.scale);
    r.child(AppRouteName.assessmentHistory,
        child: (_) => const AssessmentHistoryScreen(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);

    // ---------- Therapists / Booking (بيانات محلية حتى يتوفر endpoint) ----------
    r.child(AppRouteName.availableOptions,
        child: (_) => BlocProvider(
              create: (_) =>
                  sl<TherapistListBloc>()..add(const TherapistListRequested()),
              child: const AvailableOptionsPage(),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.doctorProfileDetails,
        child: (_) => _withArgs<String>(
              (id) => BlocProvider(
                create: (_) => sl<TherapistDetailBloc>()
                  ..add(TherapistDetailRequested(id)),
                child: const DoctorProfileDetailsPage(),
              ),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.scale);
    r.child(AppRouteName.bookingPage,
        child: (_) => _withArgs<TherapistModel>(
              (therapist) => BlocProvider(
                create: (_) =>
                    sl<BookingBloc>()..add(BookingStarted(therapist)),
                child: const BookingPage(),
              ),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);

    // ---------- Packages / Payment (واجهات فقط — لا endpoint في الباك‑إند) ----------
    r.child(AppRouteName.packages,
        child: (_) => const PackagesPage(),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.paymentSummary,
        child: (_) => _withArgs<PackageModel>(
              (package) => PaymentSummaryPage(package: package),
            ),
        transition: TransitionType.custom,
        customTransition: AppTransitions.slideRight);
    r.child(AppRouteName.thankYou, child: (_) {
      final data = Modular.args.data;
      return ThankYouPage(package: data is PackageModel ? data : null);
    },
        transition: TransitionType.custom,
        customTransition: AppTransitions.scale);
  }
}
