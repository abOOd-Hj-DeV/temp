import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/core/utils/validators.dart';
import 'package:etmaen/features/auth/presentation/blocs/session/session_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:etmaen/features/auth/presentation/widget/auth_text_field.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:etmaen/shared/widget/auth_header.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(SignInSubmitted(
            whatsappNumber: _phoneController.text,
            password: _passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0.0;

    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          AlertService.showError(context, message: state.message);
        } else if (state is SignInSuccess) {
          sl<SessionBloc>().add(SessionUserUpdated(state.session.user));
          Modular.to.navigate(AppRouteName.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.lgPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!isKeyboardOpen) ...[
                      const AuthHeader(
                        title: AppStrings.signInYourAccount,
                        subtitle: AppStrings.signInDescription,
                      ),
                      SizedBox(height: 24.h),
                    ],
                    AuthTextField(
                      label: AppStrings.phone,
                      hintText: AppStrings.phoneHint_wa,
                      icon: Iconsax.call,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: Validators.validatePhoneNumber,
                    ),
                    AuthTextField(
                      label: AppStrings.password,
                      hintText: '●●●●●●●●',
                      icon: Iconsax.lock,
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) => Validators.validateRequired(value,
                          fieldName: AppStrings.password),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () =>
                            Modular.to.pushNamed(AppRouteName.forgotPassword),
                        child: Text(
                          AppStrings.forgotPassword,
                          style: AppFonts.tajawalMedium14.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: AppStrings.signIn,
                      onPressed: _submit,
                      color: AppColors.primary,
                      textColor: Colors.white,
                      isLoading: state is SignInLoading,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.dntHave,
                            style: AppFonts.tajawalMedium14
                                .copyWith(color: AppColors.textBlack)),
                        TextButton(
                          onPressed: () =>
                              Modular.to.navigate(AppRouteName.createAccount),
                          child: Text(
                            AppStrings.regrsterNow,
                            style: AppFonts.tajawalBold16
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                      ],
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
