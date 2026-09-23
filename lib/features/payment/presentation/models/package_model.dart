class PackageModel {
  final String id;
  final String name;
  final int price;
  final int? savings;
  final bool mostPopular;
  final List<String> features;

  const PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.features,
    this.savings,
    this.mostPopular = false,
  });

  /// باقات ثابتة للعرض حتى يوفّر الباك‑إند endpoint عام للاشتراكات
  static const available = [
    PackageModel(
      id: 'four_weeks',
      name: 'باقة 4 أسابيع',
      price: 1200,
      features: [
        '8 جلسات مع المعالج (جلستان أسبوعياً)',
        'وحدات البرنامج الأساسي',
        'المحتوى التعليمي',
        'تمارين تفاعلية',
        'متابعة المزاج والنوم',
        'مراسلة المعالج (رد خلال 8 ساعات)',
      ],
    ),
    PackageModel(
      id: 'eight_weeks',
      name: 'باقة 8 أسابيع',
      price: 2200,
      savings: 200,
      mostPopular: true,
      features: [
        '16 جلسة مع المعالج (جلستان أسبوعياً)',
        'وحدات البرنامج الأساسي',
        'المحتوى الإضافي الخاص',
        'تمارين تفاعلية متقدمة',
        'متابعة شاملة للمزاج والنوم والنشاط',
        'مراسلة المعالج (رد خلال 8 ساعات)',
        'تقارير تقدم أسبوعية',
      ],
    ),
  ];
}
