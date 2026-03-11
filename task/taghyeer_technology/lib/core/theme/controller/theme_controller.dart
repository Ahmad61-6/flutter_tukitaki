  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  class ThemeController extends GetxController {
    final SharedPreferences _prefs;
    static const String _themeKey = 'isDarkMode';

    final RxBool isDarkMode = false.obs;

    ThemeController(this._prefs);

    @override
    void onInit() {
      super.onInit();
      _loadTheme();
    }

    void _loadTheme() {
      isDarkMode.value = _prefs.getBool(_themeKey) ?? false;

      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    }

    void toggleTheme() {
      isDarkMode.value = !isDarkMode.value;

      _prefs.setBool(_themeKey, isDarkMode.value);

      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    }
  }