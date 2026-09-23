import 'package:equatable/equatable.dart';

class AssessmentQuestionModel extends Equatable {
  /// المفتاح كما يتوقعه الباك‑إند: q1..qN
  final String key;
  final String question;

  const AssessmentQuestionModel({required this.key, required this.question});

  @override
  List<Object?> get props => [key, question];
}
