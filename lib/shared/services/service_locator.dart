import 'package:dio/dio.dart';
import 'package:etmaen/core/api/api_consumer.dart';
import 'package:etmaen/core/api/dio_consumer.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/core/storage/token_storage.dart';
import 'package:etmaen/features/assessment/data/repositories/assessment_repository.dart';
import 'package:etmaen/features/assessment/data/services/assessment_api_service.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_bloc.dart';
import 'package:etmaen/features/assessment/presentation/blocs/assessment_history_bloc.dart';
import 'package:etmaen/features/auth/data/repositories/auth_repository.dart';
import 'package:etmaen/features/auth/data/services/auth_api_service.dart';
import 'package:etmaen/features/auth/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/otp/otp_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/reset_password/reset_password_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/session/session_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:etmaen/features/booking/data/repositories/booking_repository.dart';
import 'package:etmaen/features/booking/data/services/booking_api_service.dart';
import 'package:etmaen/features/booking/presentation/blocs/booking_bloc.dart';
import 'package:etmaen/features/patient/data/repositories/patient_repository.dart';
import 'package:etmaen/features/patient/data/services/patient_api_service.dart';
import 'package:etmaen/features/patient/presentation/blocs/account/account_bloc.dart';
import 'package:etmaen/features/patient/presentation/blocs/appointments/appointments_bloc.dart';
import 'package:etmaen/features/patient/presentation/blocs/dashboard/dashboard_bloc.dart';
import 'package:etmaen/features/patient/presentation/blocs/profile/profile_bloc.dart';
import 'package:etmaen/features/patient/presentation/blocs/programs/programs_bloc.dart';
import 'package:etmaen/features/therapist/data/repositories/therapist_repository.dart';
import 'package:etmaen/features/therapist/data/services/therapist_api_service.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_detail/therapist_detail_bloc.dart';
import 'package:etmaen/features/therapist/presentation/blocs/therapist_list/therapist_list_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  //! Core
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => kIsWeb
      ? const AlwaysOnlineNetworkInfo()
      : NetworkInfoImpl(InternetConnectionChecker.createInstance()));
  sl.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(dio: sl(), tokenStorage: sl()));

  //! Auth
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepository(sl(), sl(), sl()));
  sl.registerLazySingleton(() => SessionBloc(sl()));
  sl.registerFactory(() => SignUpBloc(sl()));
  sl.registerFactory(() => SignInBloc(sl()));
  sl.registerFactory(() => OtpBloc(sl()));
  sl.registerFactory(() => ForgotPasswordBloc(sl()));
  sl.registerFactory(() => ResetPasswordBloc(sl()));

  //! Patient
  sl.registerLazySingleton<PatientApiService>(() => PatientApiService(sl()));
  sl.registerLazySingleton<PatientRepository>(
      () => PatientRepository(sl(), sl(), sl()));
  sl.registerFactory(() => DashboardBloc(sl()));
  sl.registerFactory(() => ProfileBloc(sl()));
  sl.registerFactory(() => AppointmentsBloc(sl()));
  sl.registerFactory(() => ProgramsBloc(sl()));
  sl.registerFactory(() => AccountBloc(sl()));

  //! Assessment
  sl.registerLazySingleton<AssessmentApiService>(
      () => AssessmentApiService(sl()));
  sl.registerLazySingleton<AssessmentRepository>(
      () => AssessmentRepository(sl(), sl()));
  sl.registerFactory(() => AssessmentBloc(sl()));
  sl.registerFactory(() => AssessmentHistoryBloc(sl()));

  //! Therapist & Booking (بيانات محلية حتى يوفر الباك‑إند endpoints)
  sl.registerLazySingleton<TherapistApiService>(
      () => TherapistApiService(sl()));
  sl.registerLazySingleton<TherapistRepository>(
      () => TherapistRepository(sl(), sl()));
  sl.registerFactory(() => TherapistListBloc(sl()));
  sl.registerFactory(() => TherapistDetailBloc(sl()));
  sl.registerLazySingleton<BookingApiService>(() => BookingApiService(sl()));
  sl.registerLazySingleton<BookingRepository>(
      () => BookingRepository(sl(), sl()));
  sl.registerFactory(() => BookingBloc(sl()));
}
