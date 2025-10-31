import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService extends GetxService {
  Future<void> saveCredential({required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', value);
    debugPrint('-------->Saved email: $value');
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    debugPrint('-------->Retrieved email: $email');
    return email?.isNotEmpty ?? false;
  }

  Future<void> removeCred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    debugPrint('-------->Removed email from SharedPreferences');
  }
}
