<div dir="rtl">

# اتّمِن | Etmaen

<p align="center">
  <img src="assets/images/logo.png" alt="اتّمِن Logo" width="150"/>
</p>

<p align="center">
  <strong>تطبيق لرعاية الصحة النفسية والعلاج الرقمي</strong><br/>
  رحلتك العلاجية في عالم الصحة النفسية تبدأ من هنا
</p>

<p align="center">
  <a href="#-المميزات">المميزات</a> •
  <a href="#-البنية التقنية">البنية التقنية</a> •
  <a href="#-هيكل المشروع">هيكل المشروع</a> •
  <a href="#-البدء">البدء</a> •
  <a href="#-الهيكلية المعمارية">الهيكلية المعمارية</a>
</p>

---

## 📱 نبذة عن المشروع

**اتّمِن** هو تطبيق موبايل مبني بإطار عمل Flutter مخصص لرعاية الصحة النفسية وتقديم خدمات العلاج الرقمي. يوفر التطبيق وصلة بين المرضى والمعالجين المرخصين من خلال جلسات علاجية عبر الفيديو، مع دعم كامل للغة العربية واتجاه RTL.

---

## ✨ المميزات

### للمستخدمين
- 🔐 **نظام مصادقة متكامل** — تسجيل دخول، إنشاء حساب، استعادة كلمة المرور عبر OTP
- 📋 **تقييم أولي ذكي** — مقياس PHQ-9 للاكتئاب لفهم الحالة النفسية
- 👨‍⚕️ **اختيار المعالج** — تصفية حسب التخصص، اللغة، الجنس، الدولة
- 📅 **حجز الجلسات** — اختيار التاريخ والوقت وطريقة التواصل (Google Meet)
- 💬 **دردشة مباشرة** — تواصل مع معالجك بين الجلسات
- 📊 **إحصائيات أسبوعية** — تتبع التقدم والتمارين المنجزة
- 🔔 **إشعارات ذكية** — تذكيرات قبل المواعيد
- 👤 **إدارة الملف الشخصي** — تعديل البيانات الشخصية وإعدادات الحساب
- 🆘 **الدعم والمساعدة** — نظام تذاكر دعم فني

### لفريق التطوير
- 🏗️ ** Clean Architecture ** — فصل واضح بين الطبقات
- 🧩 **Modular Routing** — إدارة متقدمة للمسارات عبر flutter_modular
- 📦 **State Management** — إدارة حالة باستخدام BLoC (Event/State)
- 🔌 **Dependency Injection** — حقن التبعيات عبر GetIt

---

## 🛠️ البنية التقنية

| الفئة | التقنية |
|---|---|
| **الإطار** | Flutter (Dart SDK ^3.5.1) |
| **إدارة الحالة** | flutter_bloc ^9.1.1 |
| **المسارات** | flutter_modular ^6.3.4 |
| **حقن التبعيات** | get_it ^9.2.0 |
| **عميل HTTP** | dio ^5.9.0 |
| **التخزين المحلي** | hive, shared_preferences, flutter_secure_storage |
| **التصميم** | flutter_screenutil, google_fonts, iconsax |
| **المكونات** | pinput (OTP), step_progress, confetti, dotted_border |
| **التكامل** | flutter_svg, flutter_native_splash |
| **قواعد البيانات** | Laravel REST API (`/api/v1`) — مستودع temp2 |

---

## 📁 هيكل المشروع

```
lib/
├── main.dart                          # نقطة الدخول
├── app/
│   ├── app_module.dart                # تعريف المسارات (Modular)
│   └── app_widget.dart                # MaterialApp.router
├── core/
│   ├── api/                           # استهلاك API عبر Dio
│   ├── constants/                     # الألوان، الخطوط، الأحجام، النصوص، المسارات
│   ├── error/                         # الاستثناءات والأخطاء
│   ├── network/                       # فحص الاتصال بالإنترنت
│   ├── theme/                         # الثيم ونمط النصوص
│   └── utils/                         # الأدوات المساعدة والانتقالات
├── features/
│   ├── introduction/                  # البداية والتوجيه
│   │   └── presentation/page/         # Splash, Onboarding, Welcome, Video
│   ├── auth/                          # المصادقة
│   │   ├── data/                      # النماذج، الخدمات،المستودعات
│   │   └── presentation/              # الصفحات، BLoCs, الـ Widgets
│   ├── assessment/                    # التقييم النفسي الأولي
│   ├── home/                          # الصفحة الرئيسية
│   ├── therapist/                     # الملف الشخصي للمعالج
│   ├── booking/                       # حجز الجلسات
│   ├── chat/                          # الدردشة
│   ├── appointments/                  # المواعيد
│   ├── payment/ & payments/           # المدفوعات
│   ├── profile/                       # الملف الشخصي
│   ├── programs/                      # البرامج العلاجية
│   ├── notifications/                 # الإشعارات
│   ├── emergency/                     # الطوارئ
│   └── faq/                           # الأسئلة الشائعة
└── shared/
    ├── services/                      # service_locator.dart
    └── widget/                        # مكونات مشتركة (CorePage, BottomNavBar...)
```

---

## 🚀 البدء

### المتطلبات
- Flutter SDK ^3.5.1
- Dart SDK ^3.5.1
- Android Studio / VS Code
- Emulator أو جهاز فيزيائي

### التثبيت والتشغيل

```bash
git clone https://github.com/abOOd-Hj-DeV/temp.git
cd temp
flutter pub get

# عنوان الباك‑إند (Laravel) يُمرَّر وقت البناء — الافتراضي http://127.0.0.1:8000/api/v1/
flutter run --dart-define=API_BASE_URL=https://api.example.com/api/v1/
```

### الفحص والبناء

```bash
flutter analyze
flutter test
# --no-tree-shake-icons مطلوب بسبب خط حزمة iconsax (خطأ codepoint 0 في مقلّص الأيقونات)
flutter build web --no-tree-shake-icons --dart-define=API_BASE_URL=https://api.example.com/api/v1/
flutter build apk --release --dart-define=API_BASE_URL=https://api.example.com/api/v1/
```

### ربط الباك‑إند

الطبقة المنطقية مبنية على عقود Laravel في مستودع `temp2` (بادئة `/api/v1`, مصادقة Bearer, تسجيل الدخول برقم الواتساب, OTP من 6 أرقام):

| الميزة | Endpoints | الحالة |
|---|---|---|
| المصادقة | `auth/register` `auth/login` `auth/otp/verify` `auth/otp/resend` `auth/forgot-password` `auth/reset-password` `auth/user` `auth/logout` | مربوطة (Bloc) |
| المريض | `patients/profile` (GET/PUT) `patients/dashboard` `patients/progress` `patients/appointments` `patients/programs` `patients/account` (DELETE) `patients/export-data` | مربوطة (Bloc) |
| التقييم PHQ-9 / GAD-7 | `patients/assessment` (POST) `patients/assessment/history` | مربوطة؛ نص الأسئلة محلي لأن الباك‑إند لا يوفّره |
| المعالجون / الحجز | — | **لا يوجد endpoint** في الباك‑إند؛ بيانات محلية مؤقتة في `*_api_service.dart` |
| الباقات / الدفع / الطوارئ / FAQ | — | **لا يوجد endpoint**؛ واجهات فقط بمحتوى محلي |

التوكن يُحفظ في `flutter_secure_storage` ويُضاف تلقائياً عبر `AuthInterceptor`، ولا تُطبع أي بيانات حساسة في اللوج.

---

## 🏛️ الهيكلية المعمارية

يُبنى المشروع وفق نمط **Clean Architecture** مع فصل واضح بين ثلاث طبقات:

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│  (Pages, Widgets, BLoCs)       │
├─────────────────────────────────────────┤
│             Domain Layer                │
│  (Entities, Use Cases)                  │
├─────────────────────────────────────────┤
│              Data Layer                 │
│  (Models, Repositories, DataSources,    │
│   API Services)                         │
└─────────────────────────────────────────┘
```

### تدفق البيانات

```
UI (Page/Widget)
    ↓ Event
BLoC
    ↓ Method Call
Repository
    ↓ API Call
ApiService (Dio)
    ↓ HTTP Request
Laravel API Server
```

---

## 📸 لقطات الشاشة

<div align="center">

| البداية | التسجيل | الصفحة الرئيسية |
|:---:|:---:|:---:|
| ![Splash](screenshots/splash.png) | ![Auth](screenshots/auth.png) | ![Home](screenshots/home.png) |

| اختيار المعالج | حجز جلسة | الملف الشخصي |
|:---:|:---:|:---:|
| ![Therapist](screenshots/therapist.png) | ![Booking](screenshots/booking.png) | ![Profile](screenshots/profile.png) |

</div>

---

## 🗺️ خريطة المسارات

```
/ (Splash)  ← يفحص التوكن: مسجّل → /home ، غير مسجّل → /onboarding أو /welcome
├── /onboarding → /welcome
├── /welcome
│   ├── /sign_in → /home
│   │   └── /forgot_password → /enter_otp → /create_new_password → /sign_in
│   └── /create_account → /enter_otp → /complete_profile → /home
└── /home (CorePage)
    ├── Tab: الرئيسية  → /assessment_intro_screen → /assessment_question_screen → /assessment_result_screen
    │                  → /assessment_history ، /programs ، /emergency
    ├── Tab: مواعيدي
    ├── Tab: مدفوعات  → /packages → /payment_summary → /thank_you
    └── Tab: الحساب   → /edit_personal_info ، /help_and_support ، /faq ، /privacy_policy ، /terms_and_conditions
/available_options → /doctor_profile_details → /booking_page   (بيانات محلية)
```

---

## 🤝 المساهمة

نرحب بالمساهمات! للاطلاع على الطريقة:

1. форك المستودع
2. إنشاء فرع جديد (`git checkout -b feature/`)
3. القيام بالتغييرات المطلوبة
4. الإيداع (`git commit -m 'Add feature'`)
5. الدفع (`git push origin feature/`)
6. فتح Pull Request

---

## 📄 الترخيص

هذا المشروع خاص ولا يمكن نشره. جميع الحقوق محفوظة لـ © 2025 سكينة.

---

## 📧 التواصل

للاستفسارات والدعم الفني، يرجى فتح issue على [GitHub](https://github.com/username/heal_bridge-frontend/issues).

</div>
