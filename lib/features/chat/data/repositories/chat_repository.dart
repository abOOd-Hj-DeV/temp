import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/chat/data/models/message_model.dart';
import 'package:etmaen/features/chat/data/services/chat_api_service.dart';

class ChatRepository {
  final ChatApiService apiService;
  final NetworkInfo networkInfo;

  ChatRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<MessageModel>>> getMessages({
    Map<String, dynamic>? queryParameters,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getMessages(
          queryParameters: queryParameters,
        );
        return Right(MessageModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, MessageModel>> sendMessage(
    Map<String, dynamic> data,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.sendMessage(data);
        return Right(MessageModel.fromJson(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
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
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }
}
