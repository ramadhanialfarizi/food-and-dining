import 'package:admin_aplication/model/user_model.dart';
import 'package:flutter/material.dart';

import '../helper/db_helper.dart';

class LoginProvider extends ChangeNotifier {
  bool obscurePassword = true;
  List<UserModel> _userModel = <UserModel>[];
  late DBhelper dbHelper;

  List<UserModel> get userModel => _userModel;

  LoginProvider() {
    dbHelper = DBhelper();
    _getAllUserAcc();
  }

  void _getAllUserAcc() async {
    _userModel = await dbHelper.getUser();
    notifyListeners();
  }

  // Future<UserModel> _getUserLogin(String email, String password) async {
  //   var emailUser = await dbHelper.getUserbyEmail(email);
  //   var passwordUser = await dbHelper.getUserbyPasssword(password);

  // }

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
