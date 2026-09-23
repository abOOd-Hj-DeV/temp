import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/patient/presentation/widgets/state_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// تبويب المدفوعات — لا يوفر الباك‑إند endpoints للاشتراكات/المدفوعات للمريض حالياً
class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.payments),
      ),
      body: StatePlaceholder(
        icon: Icons.credit_card_outlined,
        message: AppStrings.paymentsComingSoon,
        actionLabel: AppStrings.viewPackages,
        onRetry: () => Modular.to.pushNamed(AppRouteName.packages),
      ),
    );
  }
}
