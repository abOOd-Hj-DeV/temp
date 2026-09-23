import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_availability_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_review_model.dart';
import 'package:etmaen/features/therapist/data/services/therapist_api_service.dart';

class TherapistRepository {
  final TherapistApiService apiService;
  final NetworkInfo networkInfo;

  TherapistRepository(this.apiService, this.networkInfo);

  Future<Either<Failure, List<TherapistModel>>> getTherapists() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getTherapists();
        final therapists = TherapistModel.fromJsonList(response);
        return Right(therapists);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, TherapistModel>> getTherapistById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getTherapistById(id);
        final therapist = TherapistModel.fromJson(response);
        return Right(therapist);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, TherapistAvailabilityModel>> getTherapistsAvailability(
      String id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getTherapistsAvailability(id);
        return Right(TherapistAvailabilityModel.fromJsonList(response).first);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, List<TherapistReviewModel>>> getTherapistsReviews(
      String id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getTherapistsReviews(id);
        return Right(TherapistReviewModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(
          ServerFailure(
              errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"),
        );
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }
}
