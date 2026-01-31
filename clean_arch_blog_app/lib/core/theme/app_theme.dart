import 'package:clean_arch_blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../constants/app_sizer.dart';

class AppTheme {
  static  OutlineInputBorder _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3.w,
    ),
      borderRadius: BorderRadius.circular(10)
  );
  static final darkThemeMode = ThemeData.dark(
    useMaterial3: true,

  ).copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    inputDecorationTheme: InputDecorationThemeData(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.gradient2)
    )
  );

}