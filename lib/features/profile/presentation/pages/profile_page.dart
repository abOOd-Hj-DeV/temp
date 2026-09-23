import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_footer.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_header.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_menu_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconsax/iconsax.dart';

/// 👤 صفحة الملف الشخصي للمستخدم
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 🏔️ رأس الصفحة (يحتوي على معلومات المستخدم)
          const ProfileHeader(),

          // ⚙️ قسم إعدادات الحساب
          SliverToBoxAdapter(
            child: ProfileMenuSection(
              title: AppStrings.accountSettings,
              items: [
                ProfileMenuItem(
                  icon: Iconsax.personalcard5,
                  title: AppStrings.editPersonalData,
                  onTap: () {
                    Modular.to.pushNamed(AppRouteName.editPersonalInfo);
                  },
                ),
                ProfileMenuItem(
                  icon: Iconsax.notification5,
                  title: AppStrings.notificationSettings,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Iconsax.shield_security2,
                  title: AppStrings.changePassword,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // 🔒 قسم الخصوصية والشروط
          SliverToBoxAdapter(
            child: ProfileMenuSection(
              title: AppStrings.privacyAndTerms,
              items: [
                ProfileMenuItem(
                  icon: Iconsax.shield_security,
                  title: AppStrings.privacyPolicy,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Iconsax.note_215,
                  title: AppStrings.termsAndConditions,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Iconsax.message_question5,
                  title: AppStrings.helpAndSupport,
                  onTap: () {
                    Modular.to.pushNamed(AppRouteName.helpAndSupport);
                  },
                ),
              ],
            ),
          ),

          // ⚠️ قسم منطقة الخطر
          SliverToBoxAdapter(
            child: ProfileMenuSection(
              title: AppStrings.dangerZone,
              items: [
                ProfileMenuItem(
                  icon: Iconsax.logout5,
                  title: AppStrings.logout,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Iconsax.profile_delete5,
                  title: AppStrings.deleteAccount,
                  onTap: () {},
                  isDanger: true,
                ),
              ],
            ),
          ),

          // 🏁 حقوق النشر ورقم النسخة
          const SliverToBoxAdapter(child: ProfileFooter()),
        ],
      ),
    );
  }
}
