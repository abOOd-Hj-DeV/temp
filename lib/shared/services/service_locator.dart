import 'package:dio/dio.dart';
import 'package:etmaen/core/api/api_consumer.dart';
import 'package:etmaen/core/api/dio_consumer.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/appointments/data/repositories/appointment_repository.dart';
import 'package:etmaen/features/appointments/data/services/appointment_api_service.dart';
import 'package:etmaen/features/assessment/data/repositories/assessment_repository.dart';
import 'package:etmaen/features/assessment/data/services/assessment_api_service.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_cubit.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:etmaen/features/auth/data/services/auth_api_services.dart'
    as auth;
import 'package:etmaen/features/auth/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/otp/otp_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/reset_password/reset_password_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_in/sign_in_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_up/sign_up_cubit.dart';
import 'package:etmaen/features/booking/data/repositories/booking_repository.dart';
import 'package:etmaen/features/booking/data/services/booking_api_service.dart';
import 'package:etmaen/features/booking/presentation/block/booking_cubit.dart';
import 'package:etmaen/features/chat/data/repositories/chat_repository.dart';
import 'package:etmaen/features/chat/data/services/chat_api_service.dart';
import 'package:etmaen/features/emergency/data/repositories/emergency_repository.dart';
import 'package:etmaen/features/emergency/data/services/emergency_api_service.dart';
import 'package:etmaen/features/faq/data/repositories/faq_repository.dart';
import 'package:etmaen/features/faq/data/services/faq_api_service.dart';
import 'package:etmaen/features/home/data/repositories/home_repository.dart';
import 'package:etmaen/features/home/data/services/home_api_service.dart';
import 'package:etmaen/features/notifications/data/repositories/notification_repository.dart';
import 'package:etmaen/features/notifications/data/services/notification_api_service.dart';
import 'package:etmaen/features/payments/data/repositories/payment_repository.dart';
import 'package:etmaen/features/payments/data/services/payment_api_service.dart';
import 'package:etmaen/features/profile/data/repositories/profile_repository.dart';
import 'package:etmaen/features/profile/data/services/profile_api_service.dart';
import 'package:etmaen/features/programs/data/repositories/program_repository.dart';
import 'package:etmaen/features/programs/data/services/program_api_service.dart';
import 'package:etmaen/features/therapist/data/repositories/therapist_repository.dart';
import 'package:etmaen/features/therapist/data/services/therapist_api_service.dart';
import 'package:etmaen/features/appointments/presentation/blocs/appointment_bloc.dart';
import 'package:etmaen/features/chat/presentation/blocs/chat_cubit.dart';
import 'package:etmaen/features/home/presentation/blocs/home_cubit.dart';
import 'package:etmaen/features/programs/presentation/blocs/program_cubit.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_detail/therapist_detail_cubit.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_list/therapist_list_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  //! Features - Auth
  // Services
  sl.registerLazySingleton<auth.AuthApiService>(
      () => auth.AuthApiService(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(sl(), sl()),
  );

  // Cubits
  sl.registerFactory(() => SignUpCubit(sl()));
  sl.registerFactory(() => SignInCubit(sl()));
  sl.registerFactory(() => ForgotPasswordCubit(sl()));
  sl.registerFactory(() => ResetPasswordCubit(sl()));
  sl.registerFactory(() => VerifyOtpCubit());

  //! Features - Therapist
  sl.registerLazySingleton<TherapistApiService>(
      () => TherapistApiService(sl()));
  sl.registerLazySingleton<TherapistRepository>(
    () => TherapistRepository(sl(), sl()),
  );
  sl.registerFactory(() => TherapistListCubit(sl()));
  sl.registerFactory(() => TherapistDetailCubit(sl()));

  //! Features - Appointments
  sl.registerLazySingleton<AppointmentApiService>(
      () => AppointmentApiService(sl()));
  sl.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepository(sl(), sl()),
  );
  sl.registerFactory(() => AppointmentBloc(sl()));

  //! Features - Chat
  sl.registerLazySingleton<ChatApiService>(() => ChatApiService(sl()));
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepository(sl(), sl()),
  );
  sl.registerFactory(() => ChatCubit(sl()));

  //! Features - Programs
  sl.registerLazySingleton<ProgramApiService>(() => ProgramApiService(sl()));
  sl.registerLazySingleton<ProgramRepository>(
    () => ProgramRepository(sl(), sl()),
  );
  sl.registerFactory(() => ProgramCubit(sl()));

  //! Features - Home
  sl.registerLazySingleton<HomeApiService>(() => HomeApiService(sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(sl(), sl()),
  );
  sl.registerFactory(() => HomeCubit(sl()));

  //! Features - Profile
  sl.registerLazySingleton<ProfileApiService>(() => ProfileApiService(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(sl(), sl()),
  );

  //! Features - Assessment
  sl.registerLazySingleton<AssessmentApiService>(
      () => AssessmentApiService(sl()));
  sl.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepository(sl(), sl()),
  );

  // Cubits
  sl.registerFactory(() => AssessmentCubit(sl()));
  //! Features - Booking
  sl.registerLazySingleton<BookingApiService>(() => BookingApiService(sl()));
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepository(sl(), sl()),
  );

  // Cubits
  sl.registerFactory(() => BookingCubit(sl()));
  
  //! Features - Payments
  sl.registerLazySingleton<PaymentApiService>(() => PaymentApiService(sl()));
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepository(sl(), sl()),
  );

  //! Features - FAQ
  sl.registerLazySingleton<FaqApiService>(() => FaqApiService(sl()));
  sl.registerLazySingleton<FaqRepository>(
    () => FaqRepository(sl(), sl()),
  );

  //! Features - Emergency
  sl.registerLazySingleton<EmergencyApiService>(
      () => EmergencyApiService(sl()));
  sl.registerLazySingleton<EmergencyRepository>(
    () => EmergencyRepository(sl(), sl()),
  );

  //! Features - Notifications
  sl.registerLazySingleton<NotificationApiService>(
      () => NotificationApiService(sl()));
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepository(sl(), sl()),
  );
}
