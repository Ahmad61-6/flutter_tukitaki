import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/models/user_info.dart';

class HomeController extends GetxController {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final RxBool isLoading = true.obs;
  final Rx<UserModel?> user = Rx(null);
  static const String _userKey = 'current_user';
  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    isLoading.value = true;
    try {
      final userString = _prefs.getString(_userKey);
      if (userString != null) {
        final userJson = json.decode(userString) as Map<String, dynamic>;
        user.value = UserModel.fromJson(userJson);
        if (kDebugMode) {
          print('[HomeController] User data loaded successfully.');
        }
      } else {
        if (kDebugMode) {
          print('[HomeController] No user data found in SharedPreferences.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[HomeController] Failed to load user data: $e');
      }
      Get.snackbar(
        'Error',
        'Could not load user profile. Please try saving it again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _prefs.remove(_userKey);
    debugPrint(
      '----->[HomeController] User logged out, data removed from SharedPreferences.',
    );
    user.value = null;
  }
}
