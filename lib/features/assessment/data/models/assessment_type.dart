/// أنواع المقاييس المدعومة في الباك‑إند
enum AssessmentType {
  phq9('phq9', 'مقياس الاكتئاب PHQ-9', 9),
  gad7('gad7', 'مقياس القلق GAD-7', 7);

  const AssessmentType(this.apiValue, this.title, this.questionCount);

  final String apiValue;
  final String title;
  final int questionCount;

  static AssessmentType fromApi(String value) => AssessmentType.values
      .firstWhere((t) => t.apiValue == value, orElse: () => phq9);
}
