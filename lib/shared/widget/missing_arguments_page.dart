import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/patient/presentation/widgets/state_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// تُعرض عند فتح مسار يتطلّب arguments بدون تمريرها (بدل الانهيار)
class MissingArgumentsPage extends StatelessWidget {
  const MissingArgumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StatePlaceholder(
        icon: Icons.link_off,
        message: AppStrings.missingArguments,
        actionLabel: AppStrings.goHome,
        onRetry: () => Modular.to.navigate(AppRouteName.home),
      ),
    );
  }
}
