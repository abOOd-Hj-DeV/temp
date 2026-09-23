import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/core/storage/token_storage.dart';
import 'package:etmaen/features/auth/data/models/auth_session_model.dart';
import 'package:etmaen/features/auth/data/models/user_model.dart';
import 'package:etmaen/features/auth/data/services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService apiService;
  final NetworkInfo networkInfo;
  final TokenStorage tokenStorage;

  AuthRepository(this.apiService, this.networkInfo, this.tokenStorage);

  Future<bool> get isLoggedIn => tokenStorage.hasValidToken();

  /// يعيد `message` فقط؛ الحساب يبقى غير مفعّل حتى التحقق من OTP.
  Future<Either<Failure, String>> register({
    required String name,
    required String email,
    required String whatsappNumber,
    required String password,
    required String passwordConfirmation,
  }) {
    return _guard(() async {
      final json = await apiService.register(
        name: name,
        email: email,
        whatsappNumber: whatsappNumber,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return json['message']?.toString() ?? '';
    });
  }

  Future<Either<Failure, AuthSessionModel>> verifyOtp({
    required String whatsappNumber,
    required String otp,
  }) {
    return _guard(() async {
      final json =
          await apiService.verifyOtp(whatsappNumber: whatsappNumber, otp: otp);
      final session = AuthSessionModel.fromJson(json);
      await _persistSession(session);
      return session;
    });
  }

  Future<Either<Failure, String>> resendOtp(String whatsappNumber) {
    return _guard(() async {
      final json = await apiService.resendOtp(whatsappNumber);
      return json['message']?.toString() ?? '';
    });
  }

  Future<Either<Failure, AuthSessionModel>> login({
    required String whatsappNumber,
    required String password,
  }) {
    return _guard(() async {
      final json = await apiService.login(
          whatsappNumber: whatsappNumber, password: password);
      final session = AuthSessionModel.fromJson(json);
      await _persistSession(session);
      return session;
    });
  }

  Future<Either<Failure, String>> forgotPassword(String whatsappNumber) {
    return _guard(() async {
      final json = await apiService.forgotPassword(whatsappNumber);
      return json['message']?.toString() ?? '';
    });
  }

  Future<Either<Failure, String>> resetPassword({
    required String whatsappNumber,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) {
    return _guard(() async {
      final json = await apiService.resetPassword(
        whatsappNumber: whatsappNumber,
        otp: otp,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      await tokenStorage.clear();
      return json['message']?.toString() ?? '';
    });
  }

  Future<Either<Failure, UserModel>> currentUser() {
    return _guard(() async {
      final json = await apiService.currentUser();
      return UserModel.fromJson(
          (json['user'] as Map<String, dynamic>?) ?? const {});
    });
  }

  Future<Either<Failure, void>> logout() async {
    final result = await _guard(() => apiService.logout());
    await tokenStorage.clear();
    return result.map((_) {});
  }

  Future<void> _persistSession(AuthSessionModel session) async {
    if (session.accessToken.isNotEmpty) {
      await tokenStorage.saveToken(session.accessToken,
          expiresAt: session.expiresAt);
    }
  }

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
