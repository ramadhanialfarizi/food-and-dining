import 'package:admin_aplication/helper/db_helper.dart';
import 'package:admin_aplication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class RegisterProvider extends ChangeNotifier {
  bool obscureConfirmPassword = true;
  bool obscurePassword = true;

  // List<UserModel> _userModel = <UserModel>[];
  // late DBhelper dbHelper;

  // List<UserModel> get userModel => _userModel;

  // RegisterProvider() {
  //   dbHelper = DBhelper();
  //   _getAllUserAcc();
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

  /// Change Confirm Password Obscure
  void changeObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  /// Reset obscure Confirm password
  void resetObscureConfirm() {
    obscureConfirmPassword = true;
  }

  //// AUTHENTICATION FUNCTION
  // void _getAllUserAcc() async {
  //   _userModel = await dbHelper.getUser();
  //   notifyListeners();
  // }

  // Future<void> addUserAcc(UserModel userModel) async {
  //   await dbHelper.insertUser(userModel);
  //   _getAllUserAcc();
  // }

  // Future<UserModel> getUserAccById(int id) async {
  //   return await dbHelper.getUserByID(id);
  // }

  // void updateUser(UserModel userModel) async {
  //   await dbHelper.updateUserAccount(userModel);
  //   _getAllUserAcc();
  // }

  // void deleteUser(int id) async {
  //   await dbHelper.deleteUserAccount(id);
  //   _getAllUserAcc();
  // }
}
