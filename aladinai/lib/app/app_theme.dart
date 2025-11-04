import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart'; // Make sure this import is correct

class AppTheme {
  static TextTheme _buildTextTheme(Color baseTextColor, Brightness brightness) {
    final typography = Typography.material2021(
      platform: null,
      black: Typography.blackMountainView,
      white: Typography.whiteMountainView,
    );

    final baseTheme = GoogleFonts.poppinsTextTheme(
      brightness == Brightness.light ? typography.black : typography.white,
    );

    return baseTheme
        .copyWith(
          displayLarge: baseTheme.displayLarge?.copyWith(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.25,
          ),
          displayMedium: baseTheme.displayMedium?.copyWith(
            fontSize: 45,
            fontWeight: FontWeight.w400,
          ),
          displaySmall: baseTheme.displaySmall?.copyWith(
            fontSize: 36,
            fontWeight: FontWeight.w400,
          ),

          headlineLarge: baseTheme.headlineLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: baseTheme.headlineMedium?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
          ),
          headlineSmall: baseTheme.headlineSmall?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),

          titleLarge: baseTheme.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: baseTheme.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600, // M3 uses Medium (w500)
            letterSpacing: 0.15,
          ),
          titleSmall: baseTheme.titleSmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600, // M3 uses Medium (w500)
            letterSpacing: 0.1,
          ),

          bodyLarge: baseTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          bodyMedium: baseTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          bodySmall: baseTheme.bodySmall?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
          ),

          // --- LABEL ---
          labelLarge: baseTheme.labelLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600, // M3 uses Medium (w500)
            letterSpacing: 0.1,
          ),
          labelMedium: baseTheme.labelMedium?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600, // M3 uses Medium (w500)
            letterSpacing: 0.5,
          ),
          labelSmall: baseTheme.labelSmall?.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        )
        .apply(bodyColor: baseTextColor, displayColor: baseTextColor);
  }

  // --- LIGHT THEME ---
  static ThemeData light(Color seedColor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );

    // --- FIX: Pass the correct brightness ---
    final textTheme = _buildTextTheme(AppColors.textLight, Brightness.light);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          // Using .withOpacity() as it's the correct method
          side: BorderSide(color: colorScheme.primary.withOpacity(0.14)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundLight,
        hintStyle: textTheme.bodyMedium?.copyWith(
          // Using .withOpacity() as it's the correct method
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
        labelStyle: textTheme.labelSmall?.copyWith(
          // Using .withOpacity() as it's the correct method
          color: colorScheme.onSurface.withOpacity(0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            // Using .withOpacity() as it's the correct method
            color: colorScheme.onSurface.withOpacity(0.12),
          ), // Use scheme
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2.0),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.surface,
        contentTextStyle: textTheme.bodyMedium,
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      // Using .withOpacity() as it's the correct method
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // --- DARK THEME ---
  static ThemeData dark(Color seedColor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );

    // Build the custom text theme
    // --- FIX: Pass the correct brightness ---
    final textTheme = _buildTextTheme(AppColors.textDark, Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface, // Explicitly set color
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        hintStyle: textTheme.bodyMedium?.copyWith(
          // Using .withOpacity() as it's the correct method
          color: colorScheme.onSurface.withOpacity(0.7), // Use scheme
        ),
        labelStyle: textTheme.labelSmall?.copyWith(
          // Using .withOpacity() as it's the correct method
          color: colorScheme.onSurface.withOpacity(0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            // Using .withOpacity() as it's the correct method
            color: colorScheme.onSurface.withOpacity(0.12),
          ), // Use scheme
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2.0),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.surface,
        contentTextStyle: textTheme.bodyMedium,
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      // Using .withOpacity() as it's the correct method
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
