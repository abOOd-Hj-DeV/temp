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
- 📦 **State Management** — إدارة حالة باستخدام BLoC/Cubit
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
| **قواعد البيانات** | PocketBase (REST API) |

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

### التثبيت

```bash
# 1. استنساخ المستودع
git clone https://github.com/username/heal_bridge-frontend.git

# 2. الانتقال إلى مجلد المشروع
cd heal_bridge-frontend

# 3. تثبيت التبعيات
flutter pub get

# 4. تشغيل التطبيق
flutter run
```

### بناء التطبيق

```bash
# بناء APK (Android)
flutter build apk --release

# بناء IPA (iOS)
flutter build ios --release
```

---

## 🏛️ الهيكلية المعمارية

يُبنى المشروع وفق نمط **Clean Architecture** مع فصل واضح بين ثلاث طبقات:

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│  (Pages, Widgets, BLoCs / Cubits)       │
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
BLoC / Cubit
    ↓ Method Call
Repository
    ↓ API Call
ApiService (Dio)
    ↓ HTTP Request
PocketBase Server
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
/ (Splash)
├── /onboarding → /start_video → /assessment_intro_screen
│                                → /assessment_question_screen
│                                → /available_options
│                                → /doctor_profile_details
│                                → /booking_page
├── /welcome
│   ├── /sign_in → /home
│   │   └── /forgot_password → /enter_otp → /home
│   └── /create_account → /enter_otp → /home
└── /home (CorePage)
    ├── Tab: الرئيسية
    ├── Tab: مواعيدي
    ├── Tab: مدفوعات
    └── Tab: الحساب
        ├── /edit_personal_info
        └── /help_and_support
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
