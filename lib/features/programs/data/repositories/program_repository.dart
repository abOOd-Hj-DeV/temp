import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/programs/data/models/program_model.dart';
import 'package:etmaen/features/programs/data/models/program_module_model.dart';
import 'package:etmaen/features/programs/data/services/program_api_service.dart';

class ProgramRepository {
  final ProgramApiService apiService;
  final NetworkInfo networkInfo;

  ProgramRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<ProgramModel>>> getPrograms({
    Map<String, dynamic>? queryParameters,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getPrograms(
          queryParameters: queryParameters,
        );
        return Right(ProgramModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, ProgramModel>> getProgramById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getProgramById(id);
        return Right(ProgramModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, List<ProgramModuleModel>>> getModulesByProgram(
    String programId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getModulesByProgram(programId);
        return Right(ProgramModuleModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }
}
