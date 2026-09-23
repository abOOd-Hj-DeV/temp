import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/profile/presentation/widgets/faq_tile.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

/// الأسئلة الشائعة — محتوى ثابت محلياً (لا يوجد endpoint في الباك‑إند)
class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  static const _items = [
    (
      'كيف أبدأ العلاج؟',
      'أكمل ملفك الشخصي ثم أجرِ التقييم الأولي (PHQ-9 أو GAD-7)، وبعدها تصفّح المعالجين واختر من يناسبك.'
    ),
    (
      'كيف يمكنني حجز جلسة إضافية؟',
      'من صفحة المعالج اختر «حجز جلسة» ثم حدّد الموعد والوسيلة المناسبة لك.'
    ),
    (
      'ماذا لو فاتني موعد جلسة؟',
      'تواصل مع الدعم من صفحة «الدعم والمساعدة» لإعادة جدولة الجلسة بحسب سياسة الإلغاء.'
    ),
    (
      'كيف أتواصل مع معالجي خارج الجلسات؟',
      'التواصل خارج الجلسات يكون عبر القنوات المتاحة داخل التطبيق فقط لضمان خصوصيتك.'
    ),
    (
      'هل بياناتي آمنة؟',
      'نعم، تُخزَّن بياناتك مشفّرة ويمكنك تصدير نسخة منها أو حذف حسابك في أي وقت من صفحة الملف الشخصي.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.faq),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.lgPadding),
        children: [
          for (final (i, item) in _items.indexed)
            FAQTile(question: item.$1, answer: item.$2, isExpanded: i == 0),
        ],
      ),
    );
  }
}
