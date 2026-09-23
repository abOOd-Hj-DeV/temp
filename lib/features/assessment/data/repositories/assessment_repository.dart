import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/assessment/data/models/assessment_result_model.dart';
import 'package:etmaen/features/assessment/data/models/assessment_type.dart';
import 'package:etmaen/features/assessment/data/services/assessment_api_service.dart';

class AssessmentRepository {
  final AssessmentApiService apiService;
  final NetworkInfo networkInfo;

  AssessmentRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, AssessmentResultModel>> submit({
    required AssessmentType type,
    required Map<String, int> answers,
  }) =>
      _guard(() async => AssessmentResultModel.fromJson(
          await apiService.submit(type: type.apiValue, answers: answers)));

  Future<Either<Failure, AssessmentHistoryModel>> history() => _guard(
      () async => AssessmentHistoryModel.fromJson(await apiService.history()));

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
