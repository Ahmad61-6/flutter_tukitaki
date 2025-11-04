import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_colors.dart';
import '../app_theme.dart';

class ThemeController extends GetxController {
  final _themeMode = ThemeMode.system.obs;

  final _seedColor = AppColors.defaultSeed.obs;

  static const String _themeModeKey = 'theme_mode';
  static const String _seedColorKey = 'seed_color';

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final themeModeString = prefs.getString(_themeModeKey);
      if (themeModeString != null) {
        _themeMode.value = ThemeMode.values.firstWhere(
          (e) => e.toString() == themeModeString,
          orElse: () => ThemeMode.system,
        );
      }
    } catch (e) {
      _themeMode.value = ThemeMode.system;
    }

    try {
      final seedColorValue = prefs.getInt(_seedColorKey);
      if (seedColorValue != null) {
        _seedColor.value = Color(seedColorValue);
      }
    } catch (e) {
      _seedColor.value = AppColors.defaultSeed;
    }
  }

  ThemeMode get themeMode => _themeMode.value;

  Color get seedColor => _seedColor.value;

  ThemeData get lightTheme => AppTheme.light(_seedColor.value);

  ThemeData get darkTheme => AppTheme.dark(_seedColor.value);

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.toString());
  }

  Future<void> toggleThemeMode() async {
    final newMode = (_themeMode.value == ThemeMode.light)
        ? ThemeMode.dark
        : ThemeMode.light;
    await setThemeMode(newMode);
  }

  Future<void> setSeedColor(Color color) async {
    _seedColor.value = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_seedColorKey, color.value);
  }
}
