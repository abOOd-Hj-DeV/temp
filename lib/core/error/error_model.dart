/// نموذج الخطأ القادم من Laravel
///
/// Laravel يعيد `{"message": "...", "errors": {"field": ["msg"]}}` عند 422،
/// و `{"message": "..."}` لبقية الأخطاء.
class ErrorModel {
  final int status;
  final String errorMessage;
  final Map<String, List<String>> fieldErrors;

  const ErrorModel({
    required this.status,
    required this.errorMessage,
    this.fieldErrors = const {},
  });

  bool hasFieldError(String field) => fieldErrors.containsKey(field);

  factory ErrorModel.fromJson(Map<String, dynamic> json, int? statusCode) {
    final fieldErrors = <String, List<String>>{};
    final errors = json['errors'];
    if (errors is Map) {
      errors.forEach((key, value) {
        if (value is List) {
          fieldErrors[key.toString()] = value.map((e) => e.toString()).toList();
        } else if (value != null) {
          fieldErrors[key.toString()] = [value.toString()];
        }
      });
    }

    final firstFieldError = fieldErrors.values
        .expand((e) => e)
        .cast<String?>()
        .firstWhere((e) => e != null && e.isNotEmpty, orElse: () => null);

    final message = firstFieldError ??
        json['message']?.toString() ??
        json['error']?.toString() ??
        'حدث خطأ غير متوقع';

    return ErrorModel(
      status: statusCode ?? (json['status'] is int ? json['status'] : 500),
      errorMessage: message,
      fieldErrors: fieldErrors,
    );
  }
}
