import 'package:etmaen/features/payment/presentation/pages/packages_page.dart';
import 'package:flutter/material.dart';

/// تبويب المدفوعات = شاشة الباقات وطريقة الدفع في تصميم Figma
class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PackagesPage(showBackButton: false);
  }
}
