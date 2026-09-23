import 'package:dio/dio.dart';
import 'package:etmaen/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final options = RequestOptions(path: '/auth/login');

  group('handleDioExceptions', () {
    test('لا ينهار عند غياب response (انقطاع الشبكة)', () {
      final e = DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
      );
      expect(
        () => handleDioExceptions(e),
        throwsA(isA<ServerException>()
            .having((s) => s.errModel.status, 'status', 500)),
      );
    });

    test('يقرأ message و errors من استجابة Laravel 422', () {
      final e = DioException(
        requestOptions: options,
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: options,
          statusCode: 422,
          data: {
            'message': 'The given data was invalid.',
            'errors': {
              'whatsapp_number': ['رقم الواتساب مطلوب'],
            },
          },
        ),
      );
      expect(
        () => handleDioExceptions(e),
        throwsA(isA<ServerException>()
            .having((s) => s.errModel.status, 'status', 422)
            .having((s) => s.errModel.fieldErrors['whatsapp_number'],
                'field error', ['رقم الواتساب مطلوب'])),
      );
    });
  });
}
