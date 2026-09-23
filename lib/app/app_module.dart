import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_cubit.dart';
import 'package:etmaen/features/assessment/presentation/screens/assessment_intro_screen.dart';
import 'package:etmaen/features/assessment/presentation/screens/assessment_question_screen.dart';
import 'package:etmaen/features/auth/presentation/blocs/otp/otp_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_in/sign_in_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_up/sign_up_cubit.dart';
import 'package:etmaen/features/auth/presentation/pages/create_account_page.dart';
import 'package:etmaen/features/auth/presentation/pages/enter_otp_page.dart';
import 'package:etmaen/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:etmaen/features/auth/presentation/pages/sign_in_page.dart';
import 'package:etmaen/features/booking/presentation/block/booking_cubit.dart';
import 'package:etmaen/features/profile/presentation/pages/help_and_support_page.dart';
import 'package:etmaen/features/booking/presentation/screens/booking_page.dart';
import 'package:etmaen/features/introduction/presentation/page/onboarding_page.dart';
import 'package:etmaen/features/introduction/presentation/page/start_video.dart';
import 'package:etmaen/features/introduction/presentation/page/welcome_page.dart';
import 'package:etmaen/features/introduction/presentation/page/splash_page.dart';
import 'package:etmaen/features/profile/presentation/pages/personal_info_page.dart';
import 'package:etmaen/features/profile/presentation/pages/profile_page.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_detail/therapist_detail_cubit.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_list/therapist_list_cubit.dart';
import 'package:etmaen/features/therapist/presentation/pages/therapist_profile_details_page.dart';
import 'package:etmaen/features/therapist/presentation/pages/therapist_list_page.dart';
import 'package:etmaen/shared/widget/core_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:etmaen/core/utils/page_transitions.dart';
import 'package:etmaen/shared/services/service_locator.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      AppRouteName.splash,
      child: (_) => const SplashPage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      AppRouteName.onboarding,
      child: (_) => const OnboardingPage(),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.home,
      child: (context) => const CorePage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      AppRouteName.doctorProfileDetails,
      child: (context) {
        final String? doctorId = Modular.args.data as String?;
        return BlocProvider(
          create: (context) =>
              sl<TherapistDetailCubit>()..getTherapistDetail(doctorId!),
          child: const DoctorProfileDetailsPage(),
        );
      },
      transition: TransitionType.custom,
      customTransition: AppTransitions.scale,
    );
    r.child(
      AppRouteName.profile,
      child: (_) => const ProfilePage(),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.editPersonalInfo,
      child: (_) => const EditPersonalInfoPage(),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideUp,
    );
    r.child(
      AppRouteName.welcome,
      child: (_) => const WelcomePage(),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.createAccount,
      child: (_) => BlocProvider(
        create: (context) => sl<SignUpCubit>(),
        child: const CreateAccountScreen(),
      ),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.signIn,
      child: (_) => BlocProvider(
        create: (context) => sl<SignInCubit>(),
        child: const SignInPage(),
      ),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.enterOtp,
      child: (_) => BlocProvider(
        create: (context) => sl<VerifyOtpCubit>(),
        child: const EnterOtpPage(),
      ),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.forgotPassword,
      child: (_) => BlocProvider(
        create: (context) => sl<ForgotPasswordCubit>(),
        child: const ForgotPasswordPage(),
      ),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.helpAndSupport,
      child: (_) => const HelpAndSupportPage(),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.startVideo,
      child: (_) => const StartVideo(),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.assessmentIntroScreen,
      child: (_) => const AssessmentIntroScreen(),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.assessmentQuestionScreen,
      child: (_) => BlocProvider(
        create: (context) => sl<AssessmentCubit>(),
        child: const AssessmentQuestionScreen(),
      ),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.availableOptions,
      child: (_) => BlocProvider(
        create: (context) => sl<TherapistListCubit>()..getTherapists(),
        child: const AvailableOptionsPage(),
      ),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
    r.child(
      AppRouteName.bookingPage,
      child: (_) => BlocProvider(
        create: (context) {
          final TherapistModel? therapistModel =
              Modular.args.data as TherapistModel?;

          return sl<BookingCubit>()..getBookingDates(therapistModel?.id ?? '');
        },
        child: const BookingPage(),
      ),
      transition: TransitionType.custom,
      customTransition: AppTransitions.slideRight,
    );
  }
}
