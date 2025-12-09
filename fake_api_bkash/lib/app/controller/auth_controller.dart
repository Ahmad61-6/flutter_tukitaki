import 'dart:convert';

import 'package:fake_api_bkash/features/shared/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
 final String _tokenKey = "access-token";
 final String _userDataModel = "user-data";

 String? accessToken;
UserInfoModel? userModel;

 Future<void> saveUserData(UserInfoModel model, String token) async{
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString(_tokenKey, token);
prefs.setString(_userDataModel, jsonEncode(model.toJson()));
accessToken = token;
userModel = model;

 }

}