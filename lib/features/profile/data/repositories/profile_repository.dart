import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/auth/data/models/user_model.dart';
import 'package:etmaen/features/profile/data/models/support_ticket_model.dart';
import 'package:etmaen/features/profile/data/services/profile_api_service.dart';

class ProfileRepository {
  final ProfileApiService apiService;
  final NetworkInfo networkInfo;

  ProfileRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, UserModel>> getUserProfile(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getUserProfile(userId);
        return Right(UserModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, UserModel>> updateUserProfile(
    String userId,
    Map<String, dynamic> data, {
    bool isFromData = false,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.updateUserProfile(
          userId,
          data,
          isFromData: isFromData,
        );
        return Right(UserModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, List<SupportTicketModel>>> getSupportTickets(
    String userId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getSupportTickets(
          queryParameters: {
            'filter': '(user="$userId")',
            'sort': '-created',
          },
        );
        return Right(SupportTicketModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, SupportTicketModel>> createSupportTicket(
    Map<String, dynamic> data, {
    bool isFromData = false,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.createSupportTicket(
          data,
          isFromData: isFromData,
        );
        return Right(SupportTicketModel.fromJson(response));
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
