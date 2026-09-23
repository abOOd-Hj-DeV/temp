import 'package:etmaen/core/api/api_consumer.dart';
import 'package:etmaen/core/api/end_points.dart';

class AssessmentApiService {
  final ApiConsumer api;

  AssessmentApiService(this.api);

  Future<Map<String, dynamic>> submit({
    required String type,
    required Map<String, int> answers,
  }) async {
    final response = await api.post(EndPoint.assessment, data: {
      'type': type,
      'answers': answers,
    });
    return response is Map<String, dynamic> ? response : {};
  }

  Future<Map<String, dynamic>> history({int page = 1}) async {
    final response =
        await api.get(EndPoint.assessmentHistory, queryParameters: {
      'page': page,
    });
    return response is Map<String, dynamic> ? response : {};
  }
}
