import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../base/app_theme.dart';
import '../typography/font_configuration.dart';
import '../typography/font_sizes.dart';
import '../typography/theme_typography.dart';

/// Organic/Natural Theme with a natural style
class OrganicNaturalTheme extends AppTheme {
  @override
  bool get supportsLightMode => true;

  @override
  bool get supportsDarkMode => true;
  @override
  String get id => 'organic_natural';

  @override
  String get name => 'Organic/Natural';

  @override
  String get description =>
      'Phong cách tự nhiên với màu sắc và hình dạng hữu cơ';

  // Font sizes - using centralized configuration
  double get smallFontSize => FontSizeConfiguration.small;
  double get normalFontSize => FontSizeConfiguration.normal;
  double get mediumFontSize => FontSizeConfiguration.medium;
  double get largeFontSize => FontSizeConfiguration.large;
  double get extraLargeFontSize => FontSizeConfiguration.extraLarge;

  // Font families - sử dụng font chữ tự nhiên
  static const String defaultFontFamily = 'Comfortaa';
  static const String alternateFontFamily = 'Caveat';
  static const String serifFontFamily = 'Cormorant';

  // Base Colors - Light Mode (màu tự nhiên)
  static const Color backgroundLightColor =
      Color(0xFFF7F9F4); // Pale greenish white
  static const Color primaryLightColor = Color(0xFF4CAF50); // Green
  static const Color secondaryLightColor = Color(0xFF8BC34A); // Light green
  static const Color accentLightColor = Color(0xFFFF9800); // Cam
  static const Color surfaceLightColor = Color(0xFFFFFFFF); // White
  static const Color borderLightColor = Color(0xFFE0E0E0); // Light gray

  // Base Colors - Dark Mode
  static const Color backgroundDarkColor = Color(0xFF1E2A20); // Dark green
  static const Color primaryDarkColor = Color(0xFF81C784); // Light green
  static const Color secondaryDarkColor = Color(0xFFA5D6A7); // Very light green
  static const Color accentDarkColor = Color(0xFFFFB74D); // Light orange
  static const Color surfaceDarkColor = Color(0xFF2E3B31); // Darker green
  static const Color borderDarkColor = Color(0xFF3E4E40); // Even darker green

  // Text Colors - Light Mode
  static const Color textPrimaryLightColor = Color(0xFF2E3B31);
  static const Color textSecondaryLightColor = Color(0xFF5D6B5F);
  static const Color textDisabledLightColor = Color(0xFFAFBDB1);

  // Text Colors - Dark Mode
  static const Color textPrimaryDarkColor = Color(0xFFF7F9F4);
  static const Color textSecondaryDarkColor = Color(0xFFCFD8D0);
  static const Color textDisabledDarkColor = Color(0xFF8A9A8C);

  @override
  ThemeData get lightThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLightColor,
      colorScheme: const ColorScheme.light(
        primary: primaryLightColor,
        secondary: secondaryLightColor,
        tertiary: accentLightColor,
        error: Colors.redAccent,
        onSecondary: Colors.white,
        onSurface: textPrimaryLightColor,
      ),
      scaffoldBackgroundColor: backgroundLightColor,

      // AppBar Theme - phong cách tự nhiên
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceLightColor,
        foregroundColor: textPrimaryLightColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: normalFontSize + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryLightColor,
        ),
        iconTheme: const IconThemeData(
          color: textPrimaryLightColor,
        ),
      ),

      // Text Theme - font chữ tự nhiên
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryLightColor,
        textSecondaryLightColor,
      ),

      // Button Themes - phong cách tự nhiên, bo tròn
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLightColor,
          foregroundColor: Colors.white,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLightColor,
          side: const BorderSide(
            color: primaryLightColor,
            width: 1.5,
          ),
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLightColor,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          ),
        ),
      ),

      // Card Theme - phong cách tự nhiên, bo tròn
      cardTheme: CardThemeData(
        color: surfaceLightColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r), // Heavily rounded
        ),
        margin: EdgeInsets.all(8.r),
        shadowColor: Colors.black.withAlpha((255 * 0.05).round()),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryLightColor,
        size: 24,
        opacity: 1,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: borderLightColor,
        thickness: 1,
        space: 16,
      ),

      // Input Decoration - phong cách tự nhiên, bo tròn
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLightColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          borderSide: const BorderSide(
            color: borderLightColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          borderSide: const BorderSide(
            color: borderLightColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          borderSide: const BorderSide(
            color: primaryLightColor,
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        hintStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: normalFontSize,
          color: textSecondaryLightColor,
        ),
      ),
    );
  }

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryDarkColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryDarkColor,
        secondary: secondaryDarkColor,
        tertiary: accentDarkColor,
        surface: surfaceDarkColor,
        error: Colors.redAccent,
        onPrimary: Color(0xFF1E2A20), // Dark green
        onSecondary: Color(0xFF1E2A20), // Dark green
        onSurface: textPrimaryDarkColor,
      ),
      scaffoldBackgroundColor: backgroundDarkColor,

      // AppBar Theme - phong cách tự nhiên
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceDarkColor,
        foregroundColor: textPrimaryDarkColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: normalFontSize + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
        ),
        iconTheme: const IconThemeData(
          color: textPrimaryDarkColor,
        ),
      ),

      // Text Theme - font chữ tự nhiên
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryDarkColor,
        textSecondaryDarkColor,
      ),

      // Button Themes - phong cách tự nhiên, bo tròn
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkColor,
          foregroundColor: const Color(0xFF1E2A20), // Dark green
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E2A20), // Dark green
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDarkColor,
          side: const BorderSide(
            color: primaryDarkColor,
            width: 1.5,
          ),
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDarkColor,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.w600,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          ),
        ),
      ),

      // Card Theme - phong cách tự nhiên, bo tròn
      cardTheme: CardThemeData(
        color: surfaceDarkColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r), // Heavily rounded
        ),
        margin: EdgeInsets.all(8.r),
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryDarkColor,
        size: 24,
        opacity: 1,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: borderDarkColor,
        thickness: 1,
        space: 16,
      ),

      // Input Decoration - phong cách tự nhiên, bo tròn
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDarkColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          borderSide: const BorderSide(
            color: borderDarkColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          borderSide: const BorderSide(
            color: borderDarkColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r), // Heavily rounded
          borderSide: const BorderSide(
            color: primaryDarkColor,
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        hintStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: normalFontSize,
          color: textSecondaryDarkColor,
        ),
      ),
    );
  }

  // Helper method to get text style with Google Fonts
  static const ThemeTypography _typography =
      ThemeTypography(FontConfiguration.organicNaturalTheme);

  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    var adjustedSize = fontSize;
    double? letterSpacing;

    if (fontFamily == alternateFontFamily) {
      adjustedSize = fontSize + 4; // Handwriting font is usually smaller
      letterSpacing = 0.5;
    } else if (fontFamily == serifFontFamily) {
      adjustedSize = fontSize + 2; // Serif font is usually smaller
      letterSpacing = 0.2;
    } else {
      letterSpacing = 0.2; // default
    }

    return _typography.getTextStyle(
      fontFamily: fontFamily,
      fontSize: adjustedSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Helper method to get text theme
  TextTheme _getTextTheme(
    String fontFamily,
    double fontSize,
    Color primaryTextColor,
    Color secondaryTextColor,
  ) {
    return TextTheme(
      displayLarge: _getTextStyle(
        fontFamily:
            alternateFontFamily, // Use handwriting font for large titles
        fontSize: fontSize + 12,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displayMedium: _getTextStyle(
        fontFamily:
            alternateFontFamily, // Use handwriting font for large titles
        fontSize: fontSize + 10,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displaySmall: _getTextStyle(
        fontFamily:
            alternateFontFamily, // Use handwriting font for large titles
        fontSize: fontSize + 8,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 6,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 5,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      bodyLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        color: primaryTextColor,
      ),
      bodyMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: primaryTextColor,
      ),
      bodySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 2,
        color: secondaryTextColor,
      ),
      labelLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      labelMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 1,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
      labelSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 2,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
    );
  }
}
