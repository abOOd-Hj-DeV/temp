import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/features/auth/presentation/blocs/session/session_bloc.dart';
import 'package:etmaen/features/patient/presentation/blocs/account/account_bloc.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_footer.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_header.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_menu_section.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:iconsax/iconsax.dart';

/// صفحة الملف الشخصي للمستخدم
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<bool> _confirm(BuildContext context,
      {required String title, required String body}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(AppStrings.confirm,
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    return result == true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AccountBloc>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is AccountFailure) {
                AlertService.showError(context, message: state.message);
              } else if (state is AccountDeleted) {
                AlertService.showSuccess(context, message: state.message);
                sl<SessionBloc>().add(const SessionLogoutRequested());
              } else if (state is AccountExported) {
                AlertService.showSuccess(context,
                    message: AppStrings.exportDataSuccess);
              }
            },
          ),
          BlocListener<SessionBloc, SessionState>(
            bloc: sl<SessionBloc>(),
            listener: (context, state) {
              if (state is SessionUnauthenticated) {
                Modular.to.navigate(AppRouteName.welcome);
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) => Scaffold(
            body: CustomScrollView(
              slivers: [
                const ProfileHeader(),
                SliverToBoxAdapter(
                  child: ProfileMenuSection(
                    title: AppStrings.accountSettings,
                    items: [
                      ProfileMenuItem(
                        icon: Iconsax.personalcard5,
                        title: AppStrings.editPersonalData,
                        onTap: () =>
                            Modular.to.pushNamed(AppRouteName.editPersonalInfo),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.chart_215,
                        title: AppStrings.assessmentHistory,
                        onTap: () => Modular.to
                            .pushNamed(AppRouteName.assessmentHistory),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.book_15,
                        title: AppStrings.programs,
                        onTap: () =>
                            Modular.to.pushNamed(AppRouteName.programs),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.document_download5,
                        title: AppStrings.exportData,
                        onTap: () => context
                            .read<AccountBloc>()
                            .add(const AccountExportRequested()),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProfileMenuSection(
                    title: AppStrings.privacyAndTerms,
                    items: [
                      ProfileMenuItem(
                        icon: Iconsax.shield_security,
                        title: AppStrings.privacyPolicy,
                        onTap: () =>
                            Modular.to.pushNamed(AppRouteName.privacyPolicy),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.note_215,
                        title: AppStrings.termsAndConditions,
                        onTap: () => Modular.to
                            .pushNamed(AppRouteName.termsAndConditions),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.message_question5,
                        title: AppStrings.faq,
                        onTap: () => Modular.to.pushNamed(AppRouteName.faq),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.support,
                        title: AppStrings.helpAndSupport,
                        onTap: () =>
                            Modular.to.pushNamed(AppRouteName.helpAndSupport),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.danger5,
                        title: AppStrings.emergency,
                        onTap: () =>
                            Modular.to.pushNamed(AppRouteName.emergency),
                        isDanger: true,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProfileMenuSection(
                    title: AppStrings.dangerZone,
                    items: [
                      ProfileMenuItem(
                        icon: Iconsax.logout5,
                        title: AppStrings.logout,
                        onTap: () => sl<SessionBloc>()
                            .add(const SessionLogoutRequested()),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.profile_delete5,
                        title: AppStrings.deleteAccount,
                        isDanger: true,
                        onTap: () async {
                          final ok = await _confirm(
                            context,
                            title: AppStrings.deleteAccount,
                            body: AppStrings.deleteAccountConfirm,
                          );
                          if (ok && context.mounted) {
                            context
                                .read<AccountBloc>()
                                .add(const AccountDeleteRequested());
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: ProfileFooter()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
