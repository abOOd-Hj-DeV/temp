import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/home/data/models/weekly_stats_model.dart';
import 'package:etmaen/features/home/data/services/home_api_service.dart';

class HomeRepository {
  final HomeApiService apiService;
  final NetworkInfo networkInfo;

  HomeRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<WeeklyStatsModel>>> getWeeklyStats(
    String userId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getWeeklyStats(
          queryParameters: {
            'filter': '(user="$userId")',
            'sort': '-week_start',
            'perPage': '4',
          },
        );
        return Right(WeeklyStatsModel.fromJsonList(response));
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
