import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? errorMessage;
  final int? statusCode;
  final Map<String, List<String>> fieldErrors;

  const Failure({
    this.errorMessage,
    this.statusCode,
    this.fieldErrors = const {},
  });

  String get message => errorMessage ?? 'خطأ غير معروف';

  bool hasFieldError(String field) => fieldErrors.containsKey(field);

  @override
  List<Object?> get props => [errorMessage, statusCode, fieldErrors];
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.errorMessage,
    super.statusCode,
    super.fieldErrors,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({super.errorMessage});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.errorMessage});
}
