import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/core/utils/validators.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_up/sign_up_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/sign_up/sign_up_state.dart';
import 'package:etmaen/features/auth/presentation/widget/auth_text_field.dart';
import 'package:etmaen/shared/widget/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:etmaen/shared/widget/custom_checkbox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _genderController;
  late TextEditingController _ageController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _genderController = TextEditingController();
    _ageController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isopen = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          AlertService.showError(context, message: state.error);
        } else if (state is SignUpSuccess) {
          AlertService.showSuccess(context, message: 'تم انشاء الحساب بنجاح');
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
                      if (isopen) ...[
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
                        validator: (value) => Validators.validateRequired(value,
                            fieldName: AppStrings.fullName),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AuthTextField(
                              label: AppStrings.gender,
                              hintText: AppStrings.genderHint,
                              controller: _genderController,
                              validator: (value) => Validators.validateRequired(
                                  value,
                                  fieldName: AppStrings.gender),
                            ),
                          ),
                          const SizedBox(width: AppSizes.lgPadding),
                          Expanded(
                            child: AuthTextField(
                              label: AppStrings.age,
                              hintText: '',
                              icon: Iconsax.calendar,
                              controller: _ageController,
                              validator: (value) => Validators.validateRequired(
                                  value,
                                  fieldName: AppStrings.age),
                            ),
                          ),
                        ],
                      ),
                      AuthTextField(
                        label: AppStrings.phone,
                        hintText: AppStrings.phoneHint_wa,
                        icon: Iconsax.call,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) => Validators.validateRequired(value,
                            fieldName: AppStrings.phone),
                      ),
                      AuthTextField(
                        label: AppStrings.yourEmail,
                        hintText: AppStrings.yourEmail,
                        icon: Iconsax.sms,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
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
                      AuthTextField(
                        label: AppStrings.confirmPasswordLabels,
                        hintText: '●●●●●●●●',
                        icon: Iconsax.lock,
                        obscureText: true,
                        controller: _confirmPasswordController,
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                                value, _passwordController.text),
                      ),
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
                              color: AppColors.greyAA,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: AppStrings.createAccountBtn,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SignUpCubit>().signUp(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                  confirmPassword:
                                      _confirmPasswordController.text,
                                );
                          }
                        },
                        color: AppColors.primary,
                        textColor: Colors.white,
                        isLoading: state is SignUpLoading,
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
