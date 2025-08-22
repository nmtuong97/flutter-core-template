import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../base/app_theme.dart';
import '../typography/font_configuration.dart';
import '../typography/font_sizes.dart';
import '../typography/theme_typography.dart';

/// Cyberpunk Theme with neon colors and special effects
class CyberpunkTheme extends AppTheme {
  @override
  bool get supportsLightMode => true;

  @override
  bool get supportsDarkMode => true;
  @override
  String get id => 'cyberpunk';

  @override
  String get name => 'Cyberpunk';

  @override
  String get description => 'Futuristic neon style';

  // Font configuration - using centralized configuration directly

  // Base Colors - Dark Mode
  static const Color backgroundDarkColor = Color(0xFF0F0F13); // Space gray
  static const Color primaryDarkColor = Color(0xFFFF3BFF); // Neon pink
  static const Color secondaryDarkColor = Color(0xFF00F0FF); // Cyan blue
  static const Color accentDarkColor = Color(0xFFFFD600); // Lemon yellow
  static const Color surfaceDarkColor = Color(0xFF1A1A24); // Cosmic gray
  static const Color inactiveIconDarkColor = Color(0xFF4A4A5A);

  // Base Colors - Light Mode
  static const Color backgroundLightColor = Color(0xFFF8F9FF); // Cosmic white
  static const Color primaryLightColor = Color(0xFF00F0FF); // Neon blue
  static const Color secondaryLightColor = Color(0xFFFF3BFF); // Light pink
  static const Color accentLightColor = Color(0xFFFF6B35); // Neon orange
  static const Color surfaceLightColor = Color(0xFFFFFFFF); // Pure white
  static const Color inactiveIconLightColor = Color(0xFFB3B3C2);

  // Text Colors - Dark Mode
  static const Color textPrimaryDarkColor = Color(0xFFFFFFFF);
  static const Color textSecondaryDarkColor = Color(0xFFB3B3C2);
  static const Color textDisabledDarkColor = Color(0xFF4A4A5A);

  // Text Colors - Light Mode
  static const Color textPrimaryLightColor = Color(0xFF1A1A24);
  static const Color textSecondaryLightColor = Color(0xFF4A4A5A);
  static const Color textDisabledLightColor = Color(0xFFB3B3C2);

  // Video Player Controls
  static const Color controlBarBgDarkColor = Color(0x99000000); // 60% opacity
  static const Color controlBarBgLightColor = Color(0x99FFFFFF); // 60% opacity
  static const Color seekBarInactiveDarkColor = Color(0xFF4A4A5A);
  static const Color seekBarInactiveLightColor = Color(0xFFB3B3C2);

  @override
  ThemeData get lightThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLightColor,
      colorScheme: ColorScheme.light(
        primary: primaryLightColor,
        secondary: secondaryLightColor,
        tertiary: accentLightColor,
        surface: backgroundLightColor,
        error: Colors.red.shade600,
        onPrimary: backgroundLightColor,
        onSecondary: backgroundLightColor,
        onSurface: textPrimaryLightColor,
      ),
      scaffoldBackgroundColor: backgroundLightColor,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceLightColor,
        foregroundColor: textPrimaryLightColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.cyberpunkTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryLightColor,
          hasShadow: true,
          shadowColor: primaryLightColor,
        ),
        iconTheme: IconThemeData(color: primaryLightColor, size: 24.r),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        FontConfiguration.cyberpunkTheme.defaultFontFamily,
        FontSizeConfiguration.normal,
        textPrimaryLightColor,
        textSecondaryLightColor,
        primaryLightColor,
        secondaryLightColor,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLightColor,
          foregroundColor: Colors.white,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.cyberpunkTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.bold,
            hasShadow: true,
            shadowColor: primaryLightColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: const BorderSide(color: primaryLightColor, width: 2),
          ),
          elevation: 4,
          shadowColor: primaryLightColor.withAlpha(
            (255 * 0.5).round(),
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: surfaceLightColor,
        elevation: 4,
        shadowColor: primaryLightColor.withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: primaryLightColor.withAlpha((255 * 0.3).round()),
          ),
        ),
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: primaryLightColor,
        size: 24.r,
        opacity: 1,
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: inactiveIconLightColor.withAlpha((255 * 0.3).round()),
        thickness: 1,
        space: 1,
      ),
    );
  }

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryDarkColor,
      colorScheme: ColorScheme.dark(
        primary: primaryDarkColor,
        secondary: secondaryDarkColor,
        tertiary: accentDarkColor,
        surface: surfaceDarkColor,
        error: Colors.red.shade400,
        onPrimary: backgroundDarkColor,
        onSecondary: backgroundDarkColor,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundDarkColor,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceDarkColor,
        foregroundColor: textPrimaryDarkColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.cyberpunkTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
          hasShadow: true,
          shadowColor: primaryDarkColor,
        ),
        iconTheme: IconThemeData(color: primaryDarkColor, size: 24.r),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        FontConfiguration.cyberpunkTheme.defaultFontFamily,
        FontSizeConfiguration.normal,
        textPrimaryDarkColor,
        textSecondaryDarkColor,
        primaryDarkColor,
        secondaryDarkColor,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkColor,
          foregroundColor: backgroundDarkColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.cyberpunkTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.bold,
            color: backgroundDarkColor,
            hasShadow: true,
            shadowColor: primaryDarkColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: const BorderSide(color: primaryDarkColor, width: 2),
          ),
          elevation: 4,
          shadowColor: primaryDarkColor.withAlpha(
            (255 * 0.5).round(),
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: surfaceDarkColor,
        elevation: 4,
        shadowColor: primaryDarkColor.withAlpha((255 * 0.3).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: primaryDarkColor.withAlpha((255 * 0.3).round()),
          ),
        ),
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: primaryDarkColor,
        size: 24.r,
        opacity: 1,
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: inactiveIconDarkColor.withAlpha((255 * 0.3).round()),
        thickness: 1,
        space: 1,
      ),
    );
  }

  // Typography helper for this theme
  static const ThemeTypography _typography =
      ThemeTypography(FontConfiguration.cyberpunkTheme);

  // Helper method to get text style with Google Fonts
  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    bool hasShadow = false,
    Color? shadowColor,
  }) {
    return _typography.getTextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      hasShadow: hasShadow,
      shadowColor: shadowColor,
    );
  }

  // Helper method to get text theme
  static TextTheme _getTextTheme(
    String fontFamily,
    double fontSize,
    Color primaryTextColor,
    Color secondaryTextColor,
    Color primaryColor,
    Color secondaryColor,
  ) {
    return TextTheme(
      displayLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 12,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      displayMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 10,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      displaySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 8,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      headlineLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 6,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      headlineMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 5,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      headlineSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
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
        color: primaryColor,
      ),
      labelMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 1,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      labelSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 2,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
    );
  }
}
