import 'package:get_storage/get_storage.dart';

class OkuurValidator {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email adress';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at leasr 6 characters long.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&+(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static bool basicValidate(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool compareValidate(String? value, String? compareValue) {
    if (value == null || value.isEmpty || value == compareValue) {
      return false;
    }
    return true;
  }

  static bool rangeValidate(double? value, double minValue,double maxValue) {
    if (value == null || value>maxValue || value<minValue) {
      return false;
    }
    return true;
  }

}