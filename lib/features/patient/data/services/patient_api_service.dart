import 'package:etmaen/core/api/api_consumer.dart';
import 'package:etmaen/core/api/end_points.dart';

/// استدعاءات `/api/v1/patients/*`
class PatientApiService {
  final ApiConsumer api;

  PatientApiService(this.api);

  Future<Map<String, dynamic>> getProfile() async =>
      _asMap(await api.get(EndPoint.profile));

  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required int age,
    required String gender,
    required String language,
  }) async =>
      _asMap(await api.put(EndPoint.profile, data: {
        'full_name': fullName,
        'age': age,
        'gender': gender,
        'language': language,
      }));

  Future<Map<String, dynamic>> getOnboarding() async =>
      _asMap(await api.get(EndPoint.onboarding));

  Future<Map<String, dynamic>> getDashboard() async =>
      _asMap(await api.get(EndPoint.dashboard));

  Future<Map<String, dynamic>> getProgress() async =>
      _asMap(await api.get(EndPoint.progress));

  Future<Map<String, dynamic>> getAppointments() async =>
      _asMap(await api.get(EndPoint.appointments));

  Future<Map<String, dynamic>> getPrograms() async =>
      _asMap(await api.get(EndPoint.programs));

  Future<Map<String, dynamic>> deleteAccount() async =>
      _asMap(await api.delete(EndPoint.deleteAccount));

  Future<Map<String, dynamic>> exportData() async =>
      _asMap(await api.get(EndPoint.exportData));

  Map<String, dynamic> _asMap(dynamic response) =>
      response is Map<String, dynamic> ? response : <String, dynamic>{};
}
