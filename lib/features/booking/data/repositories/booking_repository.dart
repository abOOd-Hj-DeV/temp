import 'package:dart_either/dart_either.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:etmaen/core/error/failure.dart';
import 'package:etmaen/core/network/network_info.dart';
import 'package:etmaen/features/booking/data/models/booking_date_model.dart';
import 'package:etmaen/features/booking/data/models/booking_method_model.dart';
import 'package:etmaen/features/booking/data/models/booking_model.dart';
import 'package:etmaen/features/booking/data/models/booking_time_model.dart';
import 'package:etmaen/features/booking/data/services/booking_api_service.dart';

class BookingRepository {
  final BookingApiService bookingApiService;
  final NetworkInfo networkInfo;

  BookingRepository(this.bookingApiService, this.networkInfo);

  Future<Either<Failure, List<BookingDateModel>>> getBookingDates(
    String therapistId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await bookingApiService.getBookingDatesByTherapist(therapistId);
        return Right(BookingDateModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, List<BookingTimeModel>>> getBookingTimes(
    String slotId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await bookingApiService.getBookingTimesBySlot(slotId);
        return Right(BookingTimeModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, List<BookingMethodModel>>> getBookingMethods(
    String timeSlotId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await bookingApiService.getBookingMethodsBySlot(timeSlotId);
        return Right(BookingMethodModel.fromJsonList(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(errorMessage: e.errModel.errorMessage));
      } catch (e) {
        return Left(ServerFailure(
            errorMessage: " '${AppStrings.unknownError}' ${e.toString()}"));
      }
    }
    return const Left(NetworkFailure(errorMessage: AppStrings.noInternet));
  }

  Future<Either<Failure, Map<String, dynamic>>> bookAppointment(
    BookingModel data,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await bookingApiService.bookingAppointment(data.toJson());
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

  Future<Either<Failure, Map<String, dynamic>>> approveBooking(
    String id,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await bookingApiService.bookingApprove(id);
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
