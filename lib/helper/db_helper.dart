import 'package:admin_aplication/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBhelper {
  static DBhelper? databaseHelper;
  static late Database _database;
  final String tableName = 'users';

  DBhelper._internal() {
    databaseHelper = this;
  }

  factory DBhelper() => databaseHelper ?? DBhelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  /// CREATE DATABASE USER
  Future<Database> _initializeDb() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'user_db.db'),
      onCreate: (db, version) async {
        await db.execute(''' CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            firstName VARCHAR(200),
            lastName VARCHAR(200),
            email VARCHAR(200),
            password VARCHAR(200)
          )''');
      },
      version: 1,
    );
    return db;
  }

  /// INSERT USER ACCOUNT
  Future<void> insertUser(UserModel userModel) async {
    final Database db = await database;
    await db.insert(tableName, userModel.toMap());
  }

  /// READ ALL DATA
  Future<List<UserModel>> getUser() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((e) => UserModel.fromMap(e)).toList();
  }

  /// READ DATA BY ID
  Future<UserModel> getUserByID(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: 'id = ? ',
      whereArgs: [id],
    );
    return result.map((e) => UserModel.fromMap(e)).first;
  }

  /// READ DATA BY EMAIL
  Future<UserModel> getUserbyEmail(String email) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: 'email = ? ',
      whereArgs: [email],
    );
    return result.map((e) => UserModel.fromMap(e)).single;
  }

  /// READ DATA BY PASSWORD
  Future<UserModel> getUserbyPasssword(String password) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: 'password = ? ',
      whereArgs: [password],
    );
    return result.map((e) => UserModel.fromMap(e)).single;
  }

  /// UPDATE USER DATA
  Future<void> updateUserAccount(UserModel userModel) async {
    final db = await database;
    await db.update(
      tableName,
      userModel.toMap(),
      where: 'id = ?',
      whereArgs: [userModel.id],
    );
  }

  /// DELETE DATA USER
  Future<void> deleteUserAccount(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
