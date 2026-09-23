import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/core/utils/validators.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:etmaen/features/auth/presentation/models/otp_page_args.dart';
import 'package:etmaen/features/auth/presentation/widget/auth_text_field.dart';
import 'package:etmaen/shared/widget/auth_header.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(SignUpSubmitted(
            name: _nameController.text,
            email: _emailController.text,
            whatsappNumber: _phoneController.text,
            password: _passwordController.text,
            passwordConfirmation: _confirmPasswordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final showHeader = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          AlertService.showError(context, message: state.message);
        } else if (state is SignUpSuccess) {
          AlertService.showSuccess(context, message: state.message);
          Modular.to.pushNamed(
            AppRouteName.enterOtp,
            arguments: OtpPageArgs(
              whatsappNumber: state.whatsappNumber,
              purpose: OtpPurpose.register,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.lgPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (showHeader) ...[
                        const AuthHeader(
                          title: AppStrings.createAccount,
                          subtitle: AppStrings.createAccountDescription,
                        ),
                        SizedBox(height: 24.h),
                      ],
                      AuthTextField(
                        label: AppStrings.fullName,
                        hintText: AppStrings.fullNameHint,
                        icon: Iconsax.user,
                        controller: _nameController,
                        validator: Validators.validateName,
                      ),
                      AuthTextField(
                        label: AppStrings.phone,
                        hintText: AppStrings.phoneHint_wa,
                        icon: Iconsax.call,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: Validators.validatePhoneNumber,
                      ),
                      AuthTextField(
                        label: AppStrings.yourEmail,
                        hintText: AppStrings.emailHint,
                        icon: Iconsax.sms,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),
                      AuthTextField(
                        label: AppStrings.password,
                        hintText: AppStrings.passwordHint8,
                        icon: Iconsax.lock,
                        obscureText: true,
                        controller: _passwordController,
                        validator: Validators.validatePassword,
                      ),
                      AuthTextField(
                        label: AppStrings.confirmPasswordLabels,
                        hintText: AppStrings.rewritePassword_hint,
                        icon: Iconsax.lock,
                        obscureText: true,
                        controller: _confirmPasswordController,
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                                value, _passwordController.text),
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: AppStrings.createAccountBtn,
                        onPressed: _submit,
                        color: AppColors.primary,
                        textColor: Colors.white,
                        isLoading: state is SignUpLoading,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.Have,
                              style: AppFonts.tajawalMedium14
                                  .copyWith(color: AppColors.textBlack)),
                          TextButton(
                            onPressed: () =>
                                Modular.to.navigate(AppRouteName.signIn),
                            child: Text(
                              AppStrings.signInNow,
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
          ),
        );
      },
    );
  }
}
