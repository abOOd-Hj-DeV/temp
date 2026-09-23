import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/features/auth/presentation/blocs/otp/otp_cubit.dart';
import 'package:etmaen/features/auth/presentation/blocs/otp/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class EnterOtpPage extends StatefulWidget {
  const EnterOtpPage({super.key});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.slRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
    );

    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        if (state is VerifyOtpFailure) {
          AlertService.showError(context, message: state.error);
        } else if (state is VerifyOtpSuccess) {
          AlertService.showSuccess(context, message: state.message);
          Modular.to.navigate(AppRouteName.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: AppStrings.enterConfirmationCode,
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
                      AppStrings.otpWhatsAppDescription,
                      style: AppFonts.tajawalMedium16.copyWith(
                        color: AppColors.greyAA,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 48.h),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Center(
                        child: Pinput(
                          length: 5,
                          controller: _otpController,
                          focusNode: _focusNode,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            BlocProvider.of<VerifyOtpCubit>(context).verifyOtp(pin);
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      isLoading: state is VerifyOtpLoading,
                      text: AppStrings.sendConfirmationCode,
                      onPressed: () {
                        if (_otpController.text.length == 5) {
                          BlocProvider.of<VerifyOtpCubit>(context).verifyOtp(_otpController.text);
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
