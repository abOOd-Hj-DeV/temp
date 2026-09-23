import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppTransitions {
  /// Default transition duration
  static const Duration _defaultDuration = Duration(milliseconds: 400);

  /// Fade transition between pages
  static CustomTransition get fade => CustomTransition(
        transitionDuration: _defaultDuration,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );

  /// Slide transition from bottom to top
  static CustomTransition get slideUp => CustomTransition(
        transitionDuration: _defaultDuration,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      );

  /// Slide transition from right to left
  static CustomTransition get slideRight => CustomTransition(
        transitionDuration: _defaultDuration,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      );

  /// Scale transition from center
  static CustomTransition get scale => CustomTransition(
        transitionDuration: _defaultDuration,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            )),
            child: child,
          );
        },
      );
}
