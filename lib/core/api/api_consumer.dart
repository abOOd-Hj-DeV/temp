/// واجهة مستهلك الـ API التي تحدد العمليات الأساسية (GET, POST, PATCH, DELETE)
abstract class ApiConsumer {
  // دالة لجلب البيانات (GET)
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  // دالة لإرسال البيانات (POST)
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });
  // دالة لتحديث البيانات جزئياً (PATCH)
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });
  // دالة لحذف البيانات (DELETE)
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });
}
