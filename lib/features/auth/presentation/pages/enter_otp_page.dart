import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/core/utils/regex.dart';
import 'package:etmaen/features/auth/presentation/blocs/otp/otp_bloc.dart';
import 'package:etmaen/features/auth/presentation/blocs/session/session_bloc.dart';
import 'package:etmaen/features/auth/presentation/models/otp_page_args.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class EnterOtpPage extends StatefulWidget {
  final OtpPageArgs args;

  const EnterOtpPage({super.key, required this.args});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  static const _otpLength = 6;
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit(String otp) {
    if (!AppRegex.isOtpValid(otp)) {
      AlertService.showError(context, message: AppStrings.otpInvalid);
      return;
    }
    if (widget.args.purpose == OtpPurpose.resetPassword) {
      // endpoint إعادة التعيين يتحقق من الرمز بنفسه
      Modular.to.pushNamed(
        AppRouteName.createNewPassword,
        arguments: ResetPasswordArgs(
          whatsappNumber: widget.args.whatsappNumber,
          otp: otp,
        ),
      );
      return;
    }
    context.read<OtpBloc>().add(
        OtpSubmitted(whatsappNumber: widget.args.whatsappNumber, otp: otp));
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 56.h,
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
            color: Colors.black.withValues(alpha: 0.05),
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

    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        switch (state) {
          case OtpFailure():
            AlertService.showError(context, message: state.message);
          case OtpResent():
            AlertService.showSuccess(context, message: state.message);
          case OtpVerified():
            sl<SessionBloc>().add(SessionUserUpdated(state.session.user));
            Modular.to.navigate(AppRouteName.completeProfile);
          default:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(title: AppStrings.enterConfirmationCode),
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.lgPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${AppStrings.otpWhatsAppDescription}\n${widget.args.whatsappNumber}',
                    style: AppFonts.tajawalMedium16
                        .copyWith(color: AppColors.greyAA),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 48.h),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Center(
                      child: Pinput(
                        length: _otpLength,
                        controller: _otpController,
                        focusNode: _focusNode,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        keyboardType: TextInputType.number,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: _submit,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: TextButton(
                      onPressed: state is OtpResending
                          ? null
                          : () => context.read<OtpBloc>().add(
                              OtpResendRequested(widget.args.whatsappNumber)),
                      child: Text(
                        state is OtpResending
                            ? AppStrings.sending
                            : AppStrings.resendCode,
                        style: AppFonts.tajawalMedium14
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    isLoading: state is OtpVerifying,
                    text: AppStrings.confirm,
                    onPressed: () => _submit(_otpController.text),
                    color: AppColors.primary,
                    textColor: AppColors.white,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
