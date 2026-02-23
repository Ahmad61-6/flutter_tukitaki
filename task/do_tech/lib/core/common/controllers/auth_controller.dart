import 'dart:convert';

import 'package:do_tech/features/shared/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {

  final _tokenKey = 'user-session-key';
  final _userDataKey = 'user-model';

  String? accessToken;
  UserModel? userModel;

  Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;
  }
  Future<void> loadUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_tokenKey);
    userModel = UserModel.fromJson(
      jsonDecode(sharedPreferences.getString(_userDataKey)!),
    );
  }

  Future<bool> isUserAlreadyLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    return token != null;
  }
  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}