import 'package:internet_connection_checker/internet_connection_checker.dart';

/// واجهة لفحص حالة الاتصال بالإنترنت
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

/// على الويب لا يمكن فحص المقابس وفحوصات الحزمة تستدعي عناوين خارجية،
/// لذلك نترك Dio يكتشف انقطاع الاتصال.
class AlwaysOnlineNetworkInfo implements NetworkInfo {
  const AlwaysOnlineNetworkInfo();

  @override
  Future<bool> get isConnected async => true;
}
