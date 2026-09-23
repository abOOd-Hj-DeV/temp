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
    return ErrorModel.fromJson(responseData, statusCode);
  }
  return ErrorModel(
    status: statusCode ?? 500,
    errorMessage: switch (statusCode) {
      401 => 'انتهت الجلسة، يرجى تسجيل الدخول مجدداً',
      403 => 'ليس لديك صلاحية للقيام بهذا الإجراء',
      404 => 'العنصر المطلوب غير موجود',
      429 => 'محاولات كثيرة، حاول لاحقاً',
      _ => 'خطأ في الخادم',
    },
  );
}

Never handleDioExceptions(DioException e) {
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
          errorMessage: switch (e.type) {
            DioExceptionType.connectionTimeout => 'انتهت مهلة الاتصال',
            DioExceptionType.sendTimeout => 'انتهت مهلة الإرسال',
            DioExceptionType.receiveTimeout => 'انتهت مهلة الاستلام',
            DioExceptionType.connectionError => 'فشل الاتصال بالخادم',
            DioExceptionType.cancel => 'تم إلغاء الطلب',
            DioExceptionType.badCertificate => 'خطأ في شهادة الأمان',
            _ => 'حدث خطأ غير معروف',
          },
        ),
      );

    case DioExceptionType.badResponse:
      throw ServerException(
        errModel: _parseErrorModel(responseData, statusCode),
      );
  }
}
