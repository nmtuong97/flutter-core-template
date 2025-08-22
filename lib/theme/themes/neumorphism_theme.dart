import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../base/app_theme.dart';
import '../typography/font_configuration.dart';
import '../typography/font_sizes.dart';
import '../typography/theme_typography.dart';
// import 'package:google_fonts/google_fonts.dart';

/// Neumorphism Theme with soft 3D embossed effect
class NeumorphismTheme extends AppTheme {
  @override
  bool get supportsLightMode => true;

  @override
  bool get supportsDarkMode => true;
  static const ThemeTypography _typography =
      ThemeTypography(FontConfiguration.neumorphismTheme);

  @override
  String get id => 'neumorphism';

  @override
  String get name => 'Neumorphism';

  @override
  String get description => 'Soft 3D embossed effect';

  // Font configuration - using centralized configuration directly

  // Base Colors - Light Mode (màu nhẹ nhàng cho hiệu ứng)
  static const Color backgroundLightColor = Color(0xFFE0E5EC);

  /// Main bg
  static const Color primaryLightColor = Color(0xFF4B70E2);

  /// Primary color
  static const Color secondaryLightColor = Color(0xFF8E9AAF);

  /// Secondary
  static const Color accentLightColor = Color(0xFF6C63FF);

  /// Accent color
  static const Color surfaceLightColor = Color(0xFFE0E5EC); // Same as bg
  static const Color shadowDarkLightColor = Color(0xFFA3B1C6); // Dark
  static const Color shadowLightLightColor = Color(0xFFFFFFFF); // Light

  // Base Colors - Dark Mode
  static const Color backgroundDarkColor = Color(0xFF2D3748);

  /// Main bg
  static const Color primaryDarkColor = Color(0xFF6C63FF);

  /// Primary color
  static const Color secondaryDarkColor = Color(0xFF718096);

  /// Secondary color
  static const Color accentDarkColor = Color(0xFF4B70E2);

  /// Accent color
  static const Color surfaceDarkColor = Color(0xFF2D3748); // Same as bg
  static const Color shadowDarkDarkColor = Color(0xFF1A202C); // Dark shadow
  static const Color shadowLightDarkColor = Color(0xFF4A5568); // Light shadow

  // Text Colors - Light Mode
  /// Text color on light background
  static const Color textPrimaryLightColor = Color(0xFF2D3748);

  /// Secondary text color on light background
  static const Color textSecondaryLightColor = Color(0xFF718096);

  /// Disabled text color on light background
  static const Color textDisabledLightColor = Color(0xFFA0AEC0);

  // Text Colors - Dark Mode
  /// Text color on dark background
  static const Color textPrimaryDarkColor = Color(0xFFE2E8F0);

  /// Secondary text color on dark background
  static const Color textSecondaryDarkColor = Color(0xFFA0AEC0);

  /// Disabled text color on dark background
  static const Color textDisabledDarkColor = Color(0xFF718096);

  /// Info color
  static const Color infoColor = Color(0xFF3B82F6);

  /// Success color
  static const Color successColor = Color(0xFF10B981);

  /// Warning color
  static const Color warningColor = Color(0xFFF59E0B);

  /// Error color
  static const Color errorColor = Color(0xFFEF4444);

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
        surface: surfaceLightColor,
        error: Colors.red,
        onSecondary: Colors.white,
        onSurface: textPrimaryLightColor,
      ),
      scaffoldBackgroundColor: backgroundLightColor,

      // AppBar Theme - Dark Mode
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLightColor,
        foregroundColor: textPrimaryLightColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryLightColor,
        ),
        iconTheme: const IconThemeData(
          color: textPrimaryLightColor,
        ),
      ),

      // Text Theme - Dark Mode
      textTheme: _getTextTheme(
        FontConfiguration.neumorphismTheme.defaultFontFamily,
        FontSizeConfiguration.normal,
        textPrimaryLightColor,
        textSecondaryLightColor,
      ),

      // Button Themes - with neumorphic effect
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: surfaceLightColor,
          foregroundColor: primaryLightColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ).copyWith(
          // Neumorphic effect with BoxDecoration
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return surfaceLightColor;
              }
              return surfaceLightColor;
            },
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLightColor,
          side: BorderSide.none,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ).copyWith(
          backgroundColor: WidgetStateProperty.all(surfaceLightColor),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLightColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),

      // Card Theme - with neumorphic effect
      cardTheme: CardThemeData(
        color: surfaceLightColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.all(8.r),
        shadowColor: Colors.transparent,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryLightColor,
        size: 24,
        opacity: 1,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: shadowDarkLightColor,
        thickness: 1,
        space: 16,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLightColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        hintStyle: _getTextStyle(
          fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal,
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
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryDarkColor,
      ),
      scaffoldBackgroundColor: backgroundDarkColor,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDarkColor,
        foregroundColor: textPrimaryDarkColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
        ),
        iconTheme: const IconThemeData(
          color: textPrimaryDarkColor,
        ),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        FontConfiguration.neumorphismTheme.defaultFontFamily,
        FontSizeConfiguration.normal,
        textPrimaryDarkColor,
        textSecondaryDarkColor,
      ),

      // Button Themes - Dark Mode
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: surfaceDarkColor,
          foregroundColor: primaryDarkColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ).copyWith(
          // Neumorphic effect with BoxDecoration
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return surfaceDarkColor;
              }
              return surfaceDarkColor;
            },
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDarkColor,
          side: BorderSide.none,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ).copyWith(
          backgroundColor: WidgetStateProperty.all(surfaceDarkColor),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDarkColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),

      // Card Theme - Dark Mode
      cardTheme: CardThemeData(
        color: surfaceDarkColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.all(8.r),
        shadowColor: Colors.transparent,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryDarkColor,
        size: 24,
        opacity: 1,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: shadowLightDarkColor,
        thickness: 1,
        space: 16,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDarkColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        hintStyle: _getTextStyle(
          fontFamily: FontConfiguration.neumorphismTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal,
          color: textSecondaryDarkColor,
        ),
      ),
    );
  }

  // Helper method to get text style with Google Fonts
  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    final letterSpacing =
        (fontFamily == FontConfiguration.neumorphismTheme.defaultFontFamily ||
                fontFamily ==
                    FontConfiguration.neumorphismTheme.alternateFontFamily)
            ? 0.2
            : null;
    return _typography.getTextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Helper method to get text theme
  static TextTheme _getTextTheme(
    String fontFamily,
    double fontSize,
    Color primaryTextColor,
    Color secondaryTextColor,
  ) {
    return TextTheme(
      displayLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 12,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displayMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 10,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displaySmall: _getTextStyle(
        fontFamily: fontFamily,
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
