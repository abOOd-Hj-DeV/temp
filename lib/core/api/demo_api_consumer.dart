import 'package:etmaen/core/api/api_consumer.dart';
import 'package:etmaen/core/api/end_points.dart';
import 'package:etmaen/core/error/error_model.dart';
import 'package:etmaen/core/error/exceptions.dart';

/// وضع العرض (Demo): يحاكي استجابات Laravel محلياً بدون سيرفر
///
/// يُفعَّل بـ `--dart-define=DEMO_MODE=true`. يقبل أي رقم واتساب وكلمة سر
/// وأي OTP من 6 أرقام، ويعيد بيانات عربية ثابتة بنفس شكل استجابات `temp2`.
class DemoApiConsumer extends ApiConsumer {
  static const bool enabled =
      bool.fromEnvironment('DEMO_MODE', defaultValue: false);

  static const _latency = Duration(milliseconds: 400);
  static const _token = 'demo-token';

  bool _hasProfile = true;
  Map<String, dynamic> _patient = {
    'user_id': '1',
    'full_name': 'أحمد محمد',
    'age': 28,
    'gender': 'male',
    'language': 'ar',
    'compliance_level': 'high',
    'has_therapist': true,
    'has_subscription': true,
  };

  final List<Map<String, dynamic>> _assessments = [
    {
      'id': '1',
      'type': 'phq9',
      'score': 14,
      'completed_at': '2026-09-01T10:00:00Z',
      'interpretation': 'اكتئاب متوسط',
    },
    {
      'id': '2',
      'type': 'gad7',
      'score': 12,
      'completed_at': '2026-09-08T10:00:00Z',
      'interpretation': 'قلق متوسط',
    },
  ];

  Map<String, dynamic> get _user => {
        'id': '1',
        'name': 'أحمد محمد',
        'email': 'ahmed@example.com',
        'whatsapp_number': '+966500000000',
        'is_active': true,
        'phone_verified_at': '2026-09-01T10:00:00Z',
        'patient': _hasProfile ? _patient : null,
      };

  Map<String, dynamic> get _session => {
        'message': 'تم تسجيل الدخول بنجاح (وضع العرض)',
        'access_token': _token,
        'expires_at':
            DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        'user': _user,
      };

  static const _nextSession = {
    'id': '10',
    'therapist_id': 'therapist1',
    'session_date': '2026-09-25',
    'session_time': '18:00',
    'medium': 'video',
    'status': 'confirmed',
    'is_initial': false,
    'payment_status': 'paid',
    'price': 150,
  };

  Never _fail(int status, String message,
      [Map<String, List<String>> fields = const {}]) {
    throw ServerException(
      errModel: ErrorModel(
          status: status, errorMessage: message, fieldErrors: fields),
    );
  }

  Future<dynamic> _handle(String method, String path, Object? data) async {
    await Future.delayed(_latency);
    final body = data is Map ? Map<String, dynamic>.from(data) : const {};

    switch ((method, path)) {
      // ---------- Auth ----------
      case ('POST', EndPoint.register):
        return {
          'message': 'تم إنشاء الحساب، أدخل رمز التحقق المرسل إلى واتساب',
          'whatsapp_number': body['whatsapp_number'],
        };
      case ('POST', EndPoint.verifyOtp):
        if ('${body['otp']}'.length != 6) {
          _fail(422, 'رمز التحقق غير صحيح', {
            'otp': ['رمز التحقق يجب أن يكون 6 أرقام']
          });
        }
        return _session;
      case ('POST', EndPoint.resendOtp):
        return {'message': 'تم إعادة إرسال رمز التحقق'};
      case ('POST', EndPoint.login):
        if ('${body['password'] ?? ''}'.isEmpty) {
          _fail(422, 'بيانات الدخول غير صحيحة');
        }
        return _session;
      case ('POST', EndPoint.forgotPassword):
        return {'message': 'تم إرسال رمز إعادة التعيين إلى واتساب'};
      case ('POST', EndPoint.resetPassword):
        return {'message': 'تم تغيير كلمة المرور بنجاح'};
      case ('POST', EndPoint.authStatus):
        return {'authenticated': true, 'user': _user};
      case ('GET', EndPoint.currentUser):
        return {'user': _user};
      case ('POST', EndPoint.logout):
        return {'message': 'تم تسجيل الخروج'};

      // ---------- Patient ----------
      case ('GET', EndPoint.profile):
        return {'patient': _hasProfile ? _patient : null};
      case ('PUT', EndPoint.profile):
        _hasProfile = true;
        _patient = {
          ..._patient,
          'full_name': body['full_name'] ?? _patient['full_name'],
          'age': body['age'] ?? _patient['age'],
          'gender': body['gender'] ?? _patient['gender'],
          'language': body['language'] ?? _patient['language'],
        };
        return {'message': 'تم حفظ الملف الشخصي', 'patient': _patient};
      case ('GET', EndPoint.onboarding):
        return {
          'has_profile': _hasProfile,
          'patient': _hasProfile ? _patient : null,
          'profile_completion': _hasProfile ? 100 : 0,
          'next_steps': _hasProfile ? const [] : const ['complete_profile'],
        };
      case ('GET', EndPoint.dashboard):
        return {
          'patient': _patient,
          'latest_assessment': _assessments.last,
          'next_session': _nextSession,
          'quick_actions': const ['assessment', 'programs', 'appointments'],
        };
      case ('GET', EndPoint.progress):
        return {
          'assessment_count': _assessments.length,
          'current_score': _assessments.last['score'],
          'compliance_level': _patient['compliance_level'],
          'recent_scores': [
            for (final a in _assessments)
              {
                'type': a['type'],
                'score': a['score'],
                'date': a['completed_at']
              }
          ],
        };
      case ('GET', EndPoint.appointments):
        return {
          'upcoming': const [_nextSession],
          'past': const [
            {
              'id': '9',
              'therapist_id': 'therapist1',
              'session_date': '2026-09-11',
              'session_time': '18:00',
              'medium': 'video',
              'status': 'completed',
              'is_initial': true,
              'payment_status': 'paid',
              'price': 0,
            }
          ],
        };
      case ('GET', EndPoint.programs):
        return {
          'programs': const [
            {
              'id': '1',
              'name': 'برنامج العلاج المعرفي السلوكي',
              'description': 'برنامج 8 أسابيع لإدارة القلق والاكتئاب',
              'is_core': true,
              'modules_count': 8,
            },
            {
              'id': '2',
              'name': 'برنامج النوم الصحي',
              'description': 'تحسين جودة النوم عبر تمارين يومية',
              'is_core': false,
              'modules_count': 4,
            },
          ],
        };
      case ('DELETE', EndPoint.deleteAccount):
        return {'message': 'تم حذف الحساب'};
      case ('GET', EndPoint.exportData):
        return {'message': 'تم تجهيز نسخة من بياناتك', 'user': _user};

      // ---------- Assessment ----------
      case ('POST', EndPoint.assessment):
        if (!_hasProfile) _fail(403, 'يجب إكمال ملفك الشخصي أولاً');
        final answers = body['answers'];
        final score = answers is Map
            ? answers.values.fold<int>(0, (s, v) => s + (v is int ? v : 0))
            : 0;
        final type = '${body['type'] ?? 'phq9'}';
        final interpretation = _interpret(type, score);
        final record = {
          'id': '${_assessments.length + 1}',
          'type': type,
          'score': score,
          'completed_at': DateTime.now().toIso8601String(),
          'interpretation': interpretation,
        };
        _assessments.add(record);
        return {
          'message': 'تم حفظ التقييم',
          'assessment': record,
          'interpretation': interpretation,
          'recommendations': const [
            'حافظ على روتين نوم منتظم',
            'مارس تمارين التنفس يومياً',
            'تابع مع معالجك في الجلسة القادمة',
          ],
          'red_flag_created': score >= 20,
        };
      case ('GET', EndPoint.assessmentHistory):
        return {
          'assessments': _assessments.reversed.toList(),
          'statistics': {
            'total': _assessments.length,
            'latest_score': _assessments.last['score'],
          },
        };
    }
    _fail(404, 'العنصر المطلوب غير موجود');
  }

  String _interpret(String type, int score) {
    if (type == 'gad7') {
      if (score <= 4) return 'قلق ضعيف';
      if (score <= 9) return 'قلق خفيف';
      if (score <= 14) return 'قلق متوسط';
      return 'قلق شديد';
    }
    if (score <= 4) return 'لا يوجد اكتئاب أو ضعيف';
    if (score <= 9) return 'اكتئاب خفيف';
    if (score <= 14) return 'اكتئاب متوسط';
    if (score <= 19) return 'اكتئاب متوسط إلى شديد';
    return 'اكتئاب شديد';
  }

  @override
  Future get(String path,
          {Object? data, Map<String, dynamic>? queryParameters}) =>
      _handle('GET', path, data);

  @override
  Future post(String path,
          {Object? data,
          Map<String, dynamic>? queryParameters,
          bool isFromData = false}) =>
      _handle('POST', path, data);

  @override
  Future put(String path,
          {Object? data, Map<String, dynamic>? queryParameters}) =>
      _handle('PUT', path, data);

  @override
  Future patch(String path,
          {Object? data,
          Map<String, dynamic>? queryParameters,
          bool isFromData = false}) =>
      _handle('PATCH', path, data);

  @override
  Future delete(String path,
          {Object? data,
          Map<String, dynamic>? queryParameters,
          bool isFromData = false}) =>
      _handle('DELETE', path, data);
}
