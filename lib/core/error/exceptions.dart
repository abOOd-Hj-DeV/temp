//date
import 'package:dio/dio.dart';
import 'package:etmaen/core/error/error_model.dart';

/// استثناء مخصص لأخطاء السيرفر
class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

class CacheException implements Exception {}

ErrorModel _parseErrorModel(dynamic responseData, int? statusCode) {
  if (responseData is Map<String, dynamic>) {
    return ErrorModel.fromJson(responseData);
  }
  final msg = responseData?.toString() ?? 'خطأ في الخادم';
  return ErrorModel(
    status: statusCode ?? 500,
    errorMessage: msg,
  );
}

void handleDioExceptions(DioException e) {
  final responseData = e.response?.data;
  final statusCode = e.response?.statusCode;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
    case DioExceptionType.badCertificate:
      throw ServerException(
        errModel: ErrorModel(
          status: statusCode ?? 500,
          errorMessage: e.type == DioExceptionType.connectionTimeout
              ? 'انتهت مهلة الاتصال'
              : e.type == DioExceptionType.sendTimeout
                  ? 'انتهت مهلة الإرسال'
                  : e.type == DioExceptionType.receiveTimeout
                      ? 'انتهت مهلة الاستلام'
                      : e.type == DioExceptionType.connectionError
                          ? 'فشل الاتصال بالخادم'
                          : e.type == DioExceptionType.cancel
                              ? 'تم إلغاء الطلب'
                              : e.type == DioExceptionType.badCertificate
                                  ? 'خطأ في شهادة الأمان'
                                  : 'حدث خطأ غير معروف',
        ),
      );

    case DioExceptionType.badResponse:
      throw ServerException(
        errModel: _parseErrorModel(responseData, statusCode),
      );
  }
}

// void handleDioExceptions(DioException e) {
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//       throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
//     case DioExceptionType.sendTimeout:
//       throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
//     case DioExceptionType.receiveTimeout:
//       throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
//     case DioExceptionType.badCertificate:
//       throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
//     case DioExceptionType.cancel:
//       throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
//     case DioExceptionType.connectionError:
//       throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
//     case DioExceptionType.unknown:
//       throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
//     case DioExceptionType.badResponse:
//       switch (e.response?.statusCode) {
//         case 400: // Bad request
//           throw ServerException(
//               errModel: ErrorModel.fromJson(e.response!.data));
//         case 401: //unauthorized
//           throw ServerException(
//               errModel: ErrorModel.fromJson(e.response!.data));
//         case 403: //forbidden
//           throw ServerException(
//               errModel: ErrorModel.fromJson(e.response!.data));
//         case 404: //not found
//           throw ServerException(
//               errModel: ErrorModel.fromJson(e.response!.data));
//         case 409: //cofficient
//           throw ServerException(
//               errModel: ErrorModel.fromJson(e.response!.data));
//         case 422: //  Unprocessable Entity
//           throw ServerException(
//               errModel: ErrorModel.fromJson(e.response!.data));
//         case 504: // Server exception
//           throw ServerException(
//               errModel: ErrorModel.fromJson(e.response!.data));
//       }
//   }
// }
