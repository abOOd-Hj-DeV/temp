import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/core/utils/validators.dart';
import 'package:etmaen/features/auth/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/forgot_password/forgot_password_state.dart';
import 'package:etmaen/features/auth/presentation/widget/auth_text_field.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordFailure) {
          AlertService.showError(context, message: state.error);
        } else if (state is ForgotPasswordSuccess) {
          AlertService.showSuccess(context, message: state.message);
          Modular.to.navigate(AppRouteName.enterOtp);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: AppStrings.forgotPassword,
          ),
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
                      AppStrings.forgotPasswordDescription,
                      style: AppFonts.tajawalMedium16.copyWith(
                        color: AppColors.greyAA,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 48.h),
                    AuthTextField(
                      label: AppStrings.phone,
                      hintText: AppStrings.phoneHint_wa,
                      icon: Iconsax.call,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) => Validators.validateRequired(value,
                          fieldName: AppStrings.phone),
                    ),
                    const Spacer(),
                    CustomButton(
                      isLoading: state is ForgotPasswordLoading,
                      text: AppStrings.send,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<ForgotPasswordCubit>(context).forgotPassword(
                                _phoneController.text,
                              );
                        }
                      },
                      color: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.backTo,
                          style: AppFonts.tajawalMedium14.copyWith(
                            color: AppColors.textBlack,
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              Modular.to.navigate(AppRouteName.signIn),
                          child: Text(
                            AppStrings.signInNow,
                            style: AppFonts.tajawalBold16.copyWith(
                              color: AppColors.primary,
                            ),
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
