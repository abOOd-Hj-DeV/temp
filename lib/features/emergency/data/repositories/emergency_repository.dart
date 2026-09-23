import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/emergency/data/models/emergency_contact_model.dart';
import 'package:etmaen/features/emergency/data/services/emergency_api_service.dart';

class EmergencyRepository {
  final EmergencyApiService apiService;
  final NetworkInfo networkInfo;

  EmergencyRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<EmergencyContactModel>>> getEmergencyContacts() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getEmergencyContacts(
          queryParameters: {'filter': '(is_active=true)'},
        );
        return Right(EmergencyContactModel.fromJsonList(response));
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
