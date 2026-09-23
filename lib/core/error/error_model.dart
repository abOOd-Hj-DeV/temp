/// نموذج لتمثيل الخطأ القادم من السيرفر
class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  // تحويل JSON إلى كائن ErrorModel
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      status: jsonData["status"],
      errorMessage: jsonData["message"],
      
    );
  }
}
