import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/appointments/data/models/appointment_model.dart';
import 'package:etmaen/features/appointments/data/services/appointment_api_service.dart';

/// مستودع randevular için
class AppointmentRepository {
  final AppointmentApiService apiService;
  final NetworkInfo networkInfo;

  AppointmentRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<AppointmentModel>>> getAppointments({
    Map<String, dynamic>? queryParameters,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getAppointments(
          queryParameters: queryParameters,
        );
        return Right(AppointmentModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, AppointmentModel>> getAppointmentById(
      String id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getAppointmentById(id);
        return Right(AppointmentModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, AppointmentModel>> createAppointment(
    Map<String, dynamic> data,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.createAppointment(data);
        return Right(AppointmentModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, AppointmentModel>> updateAppointment(
    String id,
    Map<String, dynamic> data,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.updateAppointment(id, data);
        return Right(AppointmentModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, void>> deleteAppointment(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await apiService.deleteAppointment(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }
}
