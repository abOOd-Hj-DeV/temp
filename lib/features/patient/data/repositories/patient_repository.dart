import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/core/storage/token_storage.dart';
import 'package:etmaen/features/patient/data/models/appointments_model.dart';
import 'package:etmaen/features/patient/data/models/dashboard_model.dart';
import 'package:etmaen/features/patient/data/models/onboarding_status_model.dart';
import 'package:etmaen/features/patient/data/models/patient_profile_model.dart';
import 'package:etmaen/features/patient/data/models/program_model.dart';
import 'package:etmaen/features/patient/data/models/progress_model.dart';
import 'package:etmaen/features/patient/data/services/patient_api_service.dart';

class PatientRepository {
  final PatientApiService apiService;
  final NetworkInfo networkInfo;
  final TokenStorage tokenStorage;

  PatientRepository(this.apiService, this.networkInfo, this.tokenStorage);

  /// يعيد null إذا لم يُنشئ المريض ملفه بعد (`patient: null`).
  Future<Either<Failure, PatientProfileModel?>> getProfile() =>
      _guard(() async {
        final json = await apiService.getProfile();
        final patient = json['patient'];
        return patient is Map<String, dynamic>
            ? PatientProfileModel.fromJson(patient)
            : null;
      });

  Future<Either<Failure, PatientProfileModel>> updateProfile({
    required String fullName,
    required int age,
    required String gender,
    required String language,
  }) =>
      _guard(() async {
        final json = await apiService.updateProfile(
          fullName: fullName,
          age: age,
          gender: gender,
          language: language,
        );
        return PatientProfileModel.fromJson(
            (json['patient'] as Map<String, dynamic>?) ?? const {});
      });

  Future<Either<Failure, OnboardingStatusModel>> getOnboarding() =>
      _guard(() async =>
          OnboardingStatusModel.fromJson(await apiService.getOnboarding()));

  Future<Either<Failure, DashboardModel>> getDashboard() => _guard(
      () async => DashboardModel.fromJson(await apiService.getDashboard()));

  Future<Either<Failure, ProgressModel>> getProgress() => _guard(
      () async => ProgressModel.fromJson(await apiService.getProgress()));

  Future<Either<Failure, AppointmentsModel>> getAppointments() =>
      _guard(() async =>
          AppointmentsModel.fromJson(await apiService.getAppointments()));

  Future<Either<Failure, List<ProgramModel>>> getPrograms() => _guard(
      () async => ProgramModel.listFromJson(await apiService.getPrograms()));

  Future<Either<Failure, String>> deleteAccount() => _guard(() async {
        final json = await apiService.deleteAccount();
        await tokenStorage.clear();
        return json['message']?.toString() ?? '';
      });

  Future<Either<Failure, Map<String, dynamic>>> exportData() =>
      _guard(() => apiService.exportData());

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() call) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
    }
    try {
      return Right(await call());
    } on ServerException catch (e) {
      return Left(ServerFailure(
        errorMessage: e.errModel.errorMessage,
        statusCode: e.errModel.status,
        fieldErrors: e.errModel.fieldErrors,
      ));
    } catch (e) {
      return Left(ServerFailure(
          errorMessage: '${AppStrings.unknownError}: ${e.toString()}'));
    }
  }
}
