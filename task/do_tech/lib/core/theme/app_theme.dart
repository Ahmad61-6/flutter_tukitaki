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
      textTheme:  TextTheme(
        bodyLarge: TextStyle(color: AppColors.colorWhite),
        bodyMedium: TextStyle(color:AppColors.colorWhite),
      ),

      inputDecorationTheme: _inputDecorationTheme,
      checkboxTheme: _checkboxTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.colorWhite,

        foregroundColor: AppColors.colorBlack,

        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),

        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w800,
          fontFamily: 'OpenSans',
        ),

        elevation: 0,
      ),
    );
  }
  static CheckboxThemeData get _checkboxTheme {
    return CheckboxThemeData(
      fillColor: const WidgetStatePropertyAll(AppColors.cardBg),

      checkColor: const WidgetStatePropertyAll(AppColors.colorWhite),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),



    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(

      filled: true,
      fillColor: AppColors.cardBg,
      contentPadding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),


      hintStyle:  TextStyle(
        color: AppColors.hintTextColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      labelStyle: TextStyle(
        color: AppColors.textColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      errorStyle: TextStyle(
        color: AppColors.itemGradientColor[0],
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),


      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:  BorderSide(color: AppColors.cardBg2,width: 1.w),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.cardBg2,width: 1.w),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:  BorderSide(color: AppColors.cardBg2, width: 1.w),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.itemGradientColor[0], width: 1.w),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.itemGradientColor[0], width: 1.w),
      ),
    );
  }
}