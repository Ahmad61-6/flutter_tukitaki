import 'package:flutter/material.dart';

import '../constants/app_sizer.dart';
import 'app_colors.dart';


class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'OpenSans',
      scaffoldBackgroundColor: AppColors.colorWhite,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryNew,
        primary: AppColors.primaryNew,
        error: AppColors.itemGradientColor[0],
      ),

      inputDecorationTheme: _inputDecorationTheme,
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.colorWhite,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      hintStyle:  TextStyle(
        color: AppColors.hintTextColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        color: AppColors.textColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      errorStyle: TextStyle(
        color: AppColors.itemGradientColor[0],
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.levelLight),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.levelLight),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:  BorderSide(color: AppColors.primaryNew, width: 1.5.w),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.itemGradientColor[0], width: 1.5.w),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.itemGradientColor[0], width: 2.0.w),
      ),
    );
  }
}