import 'package:internet_connection_checker/internet_connection_checker.dart';

/// واجهة لفحص حالة الاتصال بالإنترنت
abstract class NetworkInfo {
  // جالب لحالة الاتصال
  Future<bool> get isConnected;
}

/// تنفيذ لواجهة فحص الشبكة باستخدام مكتبة connectionChecker
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  // التحقق الفعلي من وجود اتصال
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
