import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/faq/data/models/faq_model.dart';
import 'package:etmaen/features/faq/data/services/faq_api_service.dart';

class FaqRepository {
  final FaqApiService apiService;
  final NetworkInfo networkInfo;

  FaqRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<FaqModel>>> getFaqs() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getFaqs(
          queryParameters: {'sort': 'order'},
        );
        return Right(FaqModel.fromJsonList(response));
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
