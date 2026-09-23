import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/auth_header.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textGray9A,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: CustomCard(
          backgroundColor: AppColors.background,
          margin: EdgeInsets.zero,
          height: 0.35.sh,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: AppStrings.signIn,
                subtitle: AppStrings.welcomeDescription,
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: AppStrings.signInNow,
                  onPressed: () {
                    Modular.to.navigate(AppRouteName.signIn);
                  },
                  color: AppColors.primary,
                  textColor: AppColors.white,
                ),
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: AppStrings.createAccount,
                  onPressed: () {
                    Modular.to.navigate(AppRouteName.createAccount);
                  },
                  color: AppColors.white,
                  textColor: AppColors.primary,
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
