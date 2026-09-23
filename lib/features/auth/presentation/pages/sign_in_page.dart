import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/core/utils/validators.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_in/sign_in_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_in/sign_in_state.dart';
import 'package:etmaen/features/auth/presentation/widget/auth_text_field.dart';
import 'package:etmaen/shared/widget/auth_header.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:etmaen/shared/widget/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "demo@etmaen.com");
    _passwordController = TextEditingController(text: "demo123");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0.0;

    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          AlertService.showError(context, message: state.error);
        } else if (state is SignInSuccess) {
          AlertService.showSuccess(context, message: 'تم تسجيل الدخول بنجاح');
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
                      icon: Iconsax.sms,
                      controller: _emailController,
                      keyboardType: TextInputType.phone,
                      validator: (value) => Validators.validateRequired(value,
                          fieldName: AppStrings.phone),
                      // validator: Validators.validatePhoneNumber,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomCheckbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                            Text(
                              AppStrings.rememberMe,
                              style: AppFonts.tajawalMedium14.copyWith(
                                color: AppColors.textGray99,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Modular.to.navigate(AppRouteName.forgotPassword);
                          },
                          child: Text(
                            AppStrings.forgotPassword,
                            style: AppFonts.tajawalMedium14.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: AppStrings.signIn,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<SignInCubit>(context).signIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      color: AppColors.primary,
                      textColor: Colors.white,
                      isLoading: state is SignInLoading,
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
