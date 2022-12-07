import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool obscurePassword = true;

  /// Change Password Obscure
  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  /// Reset obscure password
  void resetObscure() {
    obscurePassword = true;
  }
}
