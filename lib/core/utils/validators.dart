import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/regex.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    } else if (!AppRegex.isEmailValid(value)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    } else if (!AppRegex.isPasswordValid(value)) {
      return AppStrings.passwordWeak;
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.phoneRequired;
    } else if (!AppRegex.isPhoneNumberValid(value)) {
      return AppStrings.phoneInvalid;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.nameRequired;
    } else if (value.length < 3) {
      return AppStrings.nameTooShort;
    }
    return null;
  }

  static String? validateRequired(String? value,
      {String fieldName = AppStrings.thisField}) {
    if (value == null || value.isEmpty) {
      return '$fieldName ${AppStrings.required}';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) return AppStrings.ageRequired;
    final age = int.tryParse(value);
    if (age == null || age < 18 || age > 120) return AppStrings.ageInvalid;
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    } else if (value != password) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }
}
