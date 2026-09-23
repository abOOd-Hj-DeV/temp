import 'package:etmaen/features/assessment/data/local/assessment_question_bank.dart';
import 'package:etmaen/features/assessment/data/models/assessment_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AssessmentQuestionBank', () {
    test('PHQ-9 يحتوي 9 أسئلة بمفاتيح q1..q9 مطابقة لعقد الباك‑إند', () {
      final qs = AssessmentQuestionBank.questionsFor(AssessmentType.phq9);
      expect(qs.length, 9);
      expect(qs.first.key, 'q1');
      expect(qs.last.key, 'q9');
    });

    test('GAD-7 يحتوي 7 أسئلة', () {
      final qs = AssessmentQuestionBank.questionsFor(AssessmentType.gad7);
      expect(qs.length, AssessmentType.gad7.questionCount);
      expect(qs.map((q) => q.key).toSet().length, 7);
    });

    test('خيارات الإجابة أربعة (0..3)', () {
      expect(AssessmentQuestionBank.options.length, 4);
    });

    test('fromApi يعيد النوع الصحيح', () {
      expect(AssessmentType.fromApi('gad7'), AssessmentType.gad7);
      expect(AssessmentType.fromApi('phq9'), AssessmentType.phq9);
    });
  });
}
