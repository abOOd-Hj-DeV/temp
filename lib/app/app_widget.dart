import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // من تصميم Figma
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          checkerboardOffscreenLayers: false,
          debugShowMaterialGrid: false,
          checkerboardRasterCacheImages: false,
          showPerformanceOverlay: false,
          showSemanticsDebugger: false,
          useInheritedMediaQuery: false,
          

          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          supportedLocales: const [
            Locale('ar'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // هنا ربطنا الثيم
          theme: AppTheme.light,
          themeMode: ThemeMode.system,

          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        );
      },
    );
  }
}
