import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/core/utils/validators.dart';
import 'package:etmaen/features/auth/presentation/blocs/reset_password/reset_password_bloc.dart';
import 'package:etmaen/features/auth/presentation/models/otp_page_args.dart';
import 'package:etmaen/features/auth/presentation/widget/auth_text_field.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CreateNewPasswordPage extends StatefulWidget {
  final ResetPasswordArgs args;

  const CreateNewPasswordPage({super.key, required this.args});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFailure) {
          AlertService.showError(context, message: state.message);
        } else if (state is ResetPasswordSuccess) {
          AlertService.showSuccess(context, message: state.message);
          Modular.to.navigate(AppRouteName.signIn);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(title: AppStrings.setpass),
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.lgPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppStrings.setpass2,
                      style: AppFonts.tajawalMedium16
                          .copyWith(color: AppColors.greyAA),
                    ),
                    SizedBox(height: 32.h),
                    AuthTextField(
                      label: AppStrings.newPassword,
                      hintText: AppStrings.passwordHint8,
                      icon: Iconsax.lock,
                      obscureText: true,
                      controller: _passwordController,
                      validator: Validators.validatePassword,
                    ),
                    AuthTextField(
                      label: AppStrings.confirmPasswordLabels,
                      hintText: AppStrings.renewPassword,
                      icon: Iconsax.lock,
                      obscureText: true,
                      controller: _confirmController,
                      validator: (value) => Validators.validateConfirmPassword(
                          value, _passwordController.text),
                    ),
                    const Spacer(),
                    CustomButton(
                      isLoading: state is ResetPasswordLoading,
                      text: AppStrings.save,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<ResetPasswordBloc>()
                              .add(ResetPasswordSubmitted(
                                whatsappNumber: widget.args.whatsappNumber,
                                otp: widget.args.otp,
                                password: _passwordController.text,
                                passwordConfirmation: _confirmController.text,
                              ));
                        }
                      },
                      color: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
