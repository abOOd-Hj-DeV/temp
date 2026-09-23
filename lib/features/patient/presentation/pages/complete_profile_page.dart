import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/features/auth/presentation/blocs/session/session_bloc.dart';
import 'package:etmaen/features/patient/presentation/blocs/profile/profile_bloc.dart';
import 'package:etmaen/features/patient/presentation/widgets/profile_form.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// إكمال ملف المريض بعد التسجيل (onboarding) — شرط لاستخدام لوحة التحكم والتقييم
class CompleteProfilePage extends StatelessWidget {
  const CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(const ProfileRequested()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailure) {
            AlertService.showError(context, message: state.message);
          } else if (state is ProfileSaved) {
            sl<SessionBloc>().add(const SessionChecked());
            Modular.to.navigate(AppRouteName.assessmentIntroScreen);
          } else if (state is ProfileLoaded) {
            Modular.to.navigate(AppRouteName.home);
          }
        },
        builder: (context, state) {
          final loading = state is ProfileLoading ||
              state is ProfileInitial ||
              state is ProfileLoaded;
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: loading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSizes.lgPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 24.h),
                          Text(
                            AppStrings.completeProfileTitle,
                            style: AppFonts.tajawalBold24
                                .copyWith(color: AppColors.textBlack),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppStrings.completeProfileDescription,
                            style: AppFonts.tajawalMedium16
                                .copyWith(color: AppColors.greyAA),
                          ),
                          SizedBox(height: 32.h),
                          ProfileForm(
                            isSaving: state is ProfileSaving,
                            onSubmit: (event) =>
                                context.read<ProfileBloc>().add(event),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
