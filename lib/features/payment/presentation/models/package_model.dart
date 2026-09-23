class PackageModel {
  final String id;
  final String name;
  final int price;
  final int sessions;
  final int durationDays;
  final List<String> features;

  const PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.sessions,
    required this.durationDays,
    required this.features,
  });

  /// باقات ثابتة للعرض حتى يوفّر الباك‑إند endpoint عام للاشتراكات
  static const available = [
    PackageModel(
      id: 'basic',
      name: 'الباقة الأساسية',
      price: 299,
      sessions: 4,
      durationDays: 30,
      features: ['4 جلسات فردية', 'متابعة عبر الرسائل', 'تقييم شهري'],
    ),
    PackageModel(
      id: 'standard',
      name: 'الباقة المتقدمة',
      price: 549,
      sessions: 8,
      durationDays: 60,
      features: [
        '8 جلسات فردية',
        'متابعة يومية عبر الرسائل',
        'برنامج علاجي مخصص',
        'تقييم كل أسبوعين',
      ],
    ),
    PackageModel(
      id: 'premium',
      name: 'الباقة الشاملة',
      price: 999,
      sessions: 16,
      durationDays: 120,
      features: [
        '16 جلسة فردية',
        'أولوية في الحجز',
        'برنامج علاجي مخصص',
        'تقارير تقدم مفصّلة',
      ],
    ),
  ];
}
