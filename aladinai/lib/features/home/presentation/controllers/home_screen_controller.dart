import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/models/user_info.dart';
import '../../../auth/presentation/controller/form_controller.dart';

class HomeController extends GetxController {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final Rx<UserModel?> user = Rx(null);
  final RxInt itemCount = 10.obs;
  final RxInt displayedItems = 10.obs;

  static const String _userKey = 'current_user';
  static const int _itemsPerLoad = 10;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    isLoading.value = true;
    try {
      final userString = _prefs.getString(_userKey);
      if (userString != null && userString.isNotEmpty) {
        final userJson = json.decode(userString) as Map<String, dynamic>;
        user.value = UserModel.fromJson(userJson);
        if (kDebugMode) {
          print('[HomeController] User data loaded successfully.');
        }
      } else {
        if (kDebugMode) {
          print('[HomeController] No user data found.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[HomeController] Error loading user data: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void loadUserData() {
    _loadUserData();
  }

  void loadMoreItems() {
    if (isLoadingMore.value || displayedItems.value >= 100) return;

    isLoadingMore.value = true;

    Future.delayed(const Duration(milliseconds: 800), () {
      final newCount = displayedItems.value + _itemsPerLoad;
      displayedItems.value = newCount > 100 ? 100 : newCount;
      itemCount.value = displayedItems.value + 1;
      isLoadingMore.value = false;
    });
  }

  Future<void> logout() async {
    // Clear form data without deleting the controller
    try {
      if (Get.isRegistered<FormController>()) {
        final formController = Get.find<FormController>();
        formController.clearFormData();
      }
    } catch (e) {
      if (kDebugMode) {
        print('[HomeController] Error clearing form data: $e');
      }
    }

    // Clear user data
    await _prefs.remove(_userKey);
    user.value = null;
    displayedItems.value = 10;
    itemCount.value = 11;

    if (kDebugMode) {
      print('[HomeController] User logged out successfully.');
    }
  }
}
