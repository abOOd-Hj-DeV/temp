import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/auth/data/models/sign_in_resp_body_model.dart';
import 'package:etmaen/features/auth/data/models/sign_up_resp_body_model.dart';
import 'package:etmaen/features/auth/data/services/auth_api_services.dart';
import 'package:etmaen/shared/services/shared_pref_service.dart';

class AuthRepository {
  AuthRepository(this.apiService, this.networkInfo);
  final AuthApiService apiService;
  final NetworkInfo networkInfo;

  Future<Either<Failure, SignInRespBodyModel>> signIn({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.signIn(
          email: email,
          password: password,
        );

        final model = SignInRespBodyModel.fromJson(response);

        await SharedPrefHelper.setSecuredString("token", model.token);
        await SharedPrefHelper.setData("userId", model.user.id);

        return Right(model);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, SignUpRespBodyModel>> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    int? age,
    String? gender,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.signUp(
          email: email,
          password: password,
          name: name,
          phone: phone,
          age: age,
          gender: gender,
        );

        final model = SignUpRespBodyModel.fromJson(response);
        return Right(model);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, String>> requestPasswordReset({
    required String email,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.requestPasswordReset(email: email);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, Map<String, dynamic>>> confirmPasswordReset({
    required String token,
    required String password,
    required String passwordConfirm,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.confirmPasswordReset(
          token: token,
          password: password,
          passwordConfirm: passwordConfirm,
        );
        return Right(response);
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
