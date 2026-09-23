import 'dart:async';

import 'package:etmaen/core/constants/app_assets.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/features/auth/presentation/blocs/session/session_bloc.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:etmaen/shared/services/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    sl<SessionBloc>().add(const SessionChecked());
    _sessionSub = sl<SessionBloc>().stream.listen(_onSession);
    _timer = Timer(const Duration(milliseconds: 1800), () {
      _animationDone = true;
      _onSession(sl<SessionBloc>().state);
    });
  }

  StreamSubscription<SessionState>? _sessionSub;
  Timer? _timer;
  bool _animationDone = false;
  bool _navigated = false;

  Future<void> _onSession(SessionState state) async {
    if (!mounted || _navigated || !_animationDone) return;
    switch (state) {
      case SessionAuthenticated():
        _navigated = true;
        Modular.to.navigate(AppRouteName.home);
      case SessionUnauthenticated():
        _navigated = true;
        final seen =
            await SharedPrefHelper.getBool(SharedPrefHelper.onboardingSeenKey);
        if (!mounted) return;
        Modular.to
            .navigate(seen ? AppRouteName.welcome : AppRouteName.onboarding);
      default:
        break;
    }
  }

  @override
  void dispose() {
    _sessionSub?.cancel();
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image(
              image: AssetImage(AppAssets.logo),
              width: 200.h,
              height: 200.w,
            ),
          ),
        ),
      ),
    );
  }
}
