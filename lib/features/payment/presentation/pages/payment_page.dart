import 'package:etmaen/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.payments),
      ),
      body: Center(
        child: Text(AppStrings.payments),
      ),
    );
  }
}
