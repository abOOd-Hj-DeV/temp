import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/features/auth/presentation/blocs/session/session_bloc.dart';
import 'package:etmaen/features/patient/data/models/patient_profile_model.dart';
import 'package:etmaen/features/patient/presentation/blocs/profile/profile_bloc.dart';
import 'package:etmaen/features/patient/presentation/widgets/profile_form.dart';
import 'package:etmaen/features/profile/presentation/widgets/personal_info_card.dart';
import 'package:etmaen/features/profile/presentation/widgets/personal_info_item.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_info_header.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// عرض وتعديل بيانات ملف المريض (`GET/PUT patients/profile`)
class EditPersonalInfoPage extends StatelessWidget {
  const EditPersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(const ProfileRequested()),
      child: const _EditPersonalInfoView(),
    );
  }
}

class _EditPersonalInfoView extends StatefulWidget {
  const _EditPersonalInfoView();

  @override
  State<_EditPersonalInfoView> createState() => _EditPersonalInfoViewState();
}

class _EditPersonalInfoViewState extends State<_EditPersonalInfoView> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    final sessionState = sl<SessionBloc>().state;
    final user =
        sessionState is SessionAuthenticated ? sessionState.user : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ProfileInfoHeader(),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailure) {
            AlertService.showError(context, message: state.message);
          } else if (state is ProfileSaved) {
            AlertService.showSuccess(context, message: AppStrings.profileSaved);
            sl<SessionBloc>().add(const SessionChecked());
            setState(() => _editing = false);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }

          final PatientProfileModel? profile = switch (state) {
            ProfileLoaded(:final profile) => profile,
            ProfileSaving(:final current) => current,
            _ => null,
          };

          if (_editing || state is ProfileMissing) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.lgPadding),
              child: ProfileForm(
                initial: profile,
                isSaving: state is ProfileSaving,
                onSubmit: (event) => context.read<ProfileBloc>().add(event),
                onCancel: state is ProfileMissing
                    ? null
                    : () => setState(() => _editing = false),
              ),
            );
          }

          if (state is ProfileFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.lgPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: AppStrings.retry,
                      onPressed: () => context
                          .read<ProfileBloc>()
                          .add(const ProfileRequested()),
                      color: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.lgPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.lgPadding,
              children: [
                Text(
                  AppStrings.currentInfo,
                  style:
                      AppFonts.tajawalBold16.copyWith(color: AppColors.black12),
                ),
                PersonalInfoCard(
                  items: [
                    PersonalInfoItem(
                      label: AppStrings.name,
                      value: profile?.fullName ?? '-',
                      onEdit: () => setState(() => _editing = true),
                    ),
                    PersonalInfoItem(
                      label: AppStrings.gender,
                      value: profile?.genderLabel ?? '-',
                      onEdit: () => setState(() => _editing = true),
                    ),
                    PersonalInfoItem(
                      label: AppStrings.age,
                      value: profile?.age?.toString() ?? '-',
                      onEdit: () => setState(() => _editing = true),
                    ),
                    PersonalInfoItem(
                      label: AppStrings.language,
                      value: profile?.languageLabel ?? '-',
                      onEdit: () => setState(() => _editing = true),
                    ),
                    PersonalInfoItem(
                      label: AppStrings.phone,
                      value: user?.whatsappNumber ?? '-',
                      showEditIcon: false,
                    ),
                    PersonalInfoItem(
                      label: AppStrings.email,
                      value: user?.email ?? '-',
                      showEditIcon: false,
                    ),
                  ],
                ),
                CustomButton(
                  text: AppStrings.editPersonalData,
                  onPressed: () => setState(() => _editing = true),
                  color: AppColors.primary,
                  textColor: AppColors.white,
                ),
                TextButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text(AppStrings.back),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
