import 'package:etmaen/features/assessment/data/models/assessment_question_model.dart';
import 'package:etmaen/features/assessment/data/models/assessment_type.dart';

/// بنك أسئلة PHQ-9 و GAD-7 (لا يوفر الباك‑إند endpoint للأسئلة، فقط للإجابات)
class AssessmentQuestionBank {
  AssessmentQuestionBank._();

  static const String intro =
      'خلال الأسبوعين الماضيين، كم مرة عانيت من:';

  /// الخيارات الأربعة تُرسل كقيم 0..3
  static const List<String> options = [
    'أبداً',
    'عدة أيام',
    'أكثر من نصف الأيام',
    'تقريباً كل يوم',
  ];

  static const List<String> _phq9 = [
    'قلة الاهتمام أو الاستمتاع بالقيام بالأشياء',
    'الشعور بالإحباط أو الاكتئاب أو اليأس',
    'صعوبة في النوم أو الاستمرار فيه، أو النوم أكثر من اللازم',
    'الشعور بالتعب أو قلة الطاقة',
    'ضعف الشهية أو الإفراط في الأكل',
    'الشعور بالسوء تجاه نفسك، أو أنك فاشل أو خذلت نفسك أو عائلتك',
    'صعوبة في التركيز على الأشياء مثل قراءة الصحف أو مشاهدة التلفاز',
    'التحرك أو التحدث ببطء لدرجة يلاحظها الآخرون، أو العكس: التململ والتوتر أكثر من المعتاد',
    'أفكار بأنك ستكون أفضل حالاً لو كنت ميتاً، أو أفكار بإيذاء نفسك',
  ];

  static const List<String> _gad7 = [
    'الشعور بالعصبية أو القلق أو التوتر',
    'عدم القدرة على التوقف عن القلق أو السيطرة عليه',
    'القلق المفرط بشأن أمور مختلفة',
    'صعوبة في الاسترخاء',
    'التململ لدرجة يصعب فيها الجلوس بهدوء',
    'الانزعاج أو الغضب بسهولة',
    'الشعور بالخوف كأن شيئاً فظيعاً قد يحدث',
  ];

  static List<AssessmentQuestionModel> questionsFor(AssessmentType type) {
    final texts = switch (type) {
      AssessmentType.phq9 => _phq9,
      AssessmentType.gad7 => _gad7,
    };
    return List.generate(
      texts.length,
      (i) => AssessmentQuestionModel(key: 'q${i + 1}', question: texts[i]),
    );
  }
}
