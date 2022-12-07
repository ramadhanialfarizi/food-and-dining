import 'package:admin_aplication/helper/db_helper.dart';
import 'package:admin_aplication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class RegisterProvider extends ChangeNotifier {
  bool obscureConfirmPassword = true;
  bool obscurePassword = true;

  List<UserModel> userModel = <UserModel>[];
  late DBhelper dbHelper;

  /// Change Password Obscure
  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  /// Reset obscure password
  void resetObscure() {
    obscurePassword = true;
  }

  /// Change Confirm Password Obscure
  void changeObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  /// Reset obscure Confirm password
  void resetObscureConfirm() {
    obscureConfirmPassword = true;
  }
}
