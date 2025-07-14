import 'package:flutter/material.dart';

import '../../../utility/app_colors.dart';

class AppThemeData {
  static ThemeData lightThemeData = ThemeData(
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey.shade400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Colors.grey.shade600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, letterSpacing: 0.5),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      elevation: 5,
      backgroundColor: Colors.white,
    ),
  );
}
