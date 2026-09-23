import 'package:dio/dio.dart';
import 'package:etmaen/shared/services/shared_pref_service.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SharedPrefHelper.getSecuredString("token") ?? "";
    options.headers["Authorization"] = token ?? "";
    super.onRequest(options, handler);
  }
}
