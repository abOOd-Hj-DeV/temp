import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/payments/data/models/payment_model.dart';
import 'package:etmaen/features/payments/data/services/payment_api_service.dart';

class PaymentRepository {
  final PaymentApiService apiService;
  final NetworkInfo networkInfo;

  PaymentRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<PaymentModel>>> getPayments(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getPayments(
          queryParameters: {
            'filter': '(user="$userId")',
            'sort': '-created',
          },
        );
        return Right(PaymentModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, PaymentModel>> createPayment(
    Map<String, dynamic> data, {
    bool isFromData = false,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.createPayment(
          data,
          isFromData: isFromData,
        );
        return Right(PaymentModel.fromJson(response));
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
