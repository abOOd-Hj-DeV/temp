import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/notifications/data/models/notification_model.dart';
import 'package:etmaen/features/notifications/data/services/notification_api_service.dart';

class NotificationRepository {
  final NotificationApiService apiService;
  final NetworkInfo networkInfo;

  NotificationRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<AppNotificationModel>>> getNotifications(
    String userId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getNotifications(
          queryParameters: {
            'filter': '(user="$userId")',
            'sort': '-created',
          },
        );
        return Right(AppNotificationModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, void>> markAsRead(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await apiService.markAsRead(id);
        return const Right(null);
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
