import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';

enum AlertType { success, error, warning, info }

class AlertService {
  AlertService._();
  static void showAlert({
    required BuildContext context,
    required String message,
    required AlertType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    AlertInfo.show(
      position: MessagePosition.bottom,
      context: context,
      text: message,
      typeInfo: _getAlertInfoType(type),
      duration: duration.inSeconds,
    );
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
  }) {
    showAlert(
      context: context,
      message: message,
      type: AlertType.success,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
  }) {
    showAlert(
      context: context,
      message: message,
      type: AlertType.error,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
  }) {
    showAlert(
      context: context,
      message: message,
      type: AlertType.warning,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
  }) {
    showAlert(
      context: context,
      message: message,
      type: AlertType.info,
    );
  }

  static TypeInfo _getAlertInfoType(AlertType type) {
    switch (type) {
      case AlertType.success:
        return TypeInfo.success;
      case AlertType.error:
        return TypeInfo.error;
      case AlertType.warning:
        return TypeInfo.warning;
      case AlertType.info:
        return TypeInfo.info;
    }
  }
}
