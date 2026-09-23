import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/assessment/data/models/assessment_templates.dart';
import 'package:etmaen/features/assessment/data/services/assessment_api_service.dart';

class AssessmentRepository {
  final AssessmentApiService apiService;
  final NetworkInfo networkInfo;

  AssessmentRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<AssessmentTemplateModel>>>
      getAssessments() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getAssessments();
        final models = AssessmentTemplateModel.fromJsonList(response);
        return Right(models);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, AssessmentTemplateModel>> getAssessmentById(
    String id,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getAssessmentById(id);
        return Right(AssessmentTemplateModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, AssessmentTemplateModel>> submitAssessment(
    Map<String, dynamic> question,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.submitAssessment(question);
        return Right(AssessmentTemplateModel.fromJson(response));
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
