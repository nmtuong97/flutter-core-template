import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../base/app_theme.dart';

/// Night Sky Theme with dark and blue colors
class NightSkyTheme extends AppTheme {
  @override
  String get id => 'night_sky';

  @override
  String get name => 'Night Sky';

  @override
  String get description => 'Dark blue theme with stars';

  // Font sizes
  static const double smallFontSize = 12;
  static const double normalFontSize = 14;
  static const double mediumFontSize = 16;
  static const double largeFontSize = 18;
  static const double extraLargeFontSize = 22;

  // Font families
  static const String defaultFontFamily = 'Roboto';
  static const String alternateFontFamily = 'Poppins';
  static const String serifFontFamily = 'Merriweather';

  // Base Colors - Dark Mode
  static const Color backgroundDarkColor = Color(0xFF0A1128); // Deep night blue
  static const Color primaryDarkColor = Color(0xFF00A8E8); // Bright blue
  static const Color secondaryDarkColor = Color(0xFF7B68EE); // Light purple
  static const Color accentDarkColor = Color(0xFFFFD700); // Star yellow
  static const Color surfaceDarkColor = Color(0xFF1A2A52); // Light night blue
  static const Color inactiveIconDarkColor = Color(0xFF4A5A8A);

  // Base Colors - Light Mode
  static const Color backgroundLightColor = Color(0xFFF0F8FF); // Light blue
  static const Color primaryLightColor = Color(0xFF1E88E5); // Blue
  static const Color secondaryLightColor = Color(0xFF7B68EE); // Light purple
  static const Color accentLightColor = Color(0xFFFFD700); // Star yellow
  static const Color surfaceLightColor = Color(0xFFFFFFFF); // White
  static const Color inactiveIconLightColor = Color(0xFFB3C2E0);

  // Text Colors - Dark Mode
  static const Color textPrimaryDarkColor = Color(0xFFFFFFFF);
  static const Color textSecondaryDarkColor = Color(0xFFB3C2E0);
  static const Color textDisabledDarkColor = Color(0xFF4A5A8A);

  // Text Colors - Light Mode
  static const Color textPrimaryLightColor = Color(0xFF0A1128);
  static const Color textSecondaryLightColor = Color(0xFF4A5A8A);
  static const Color textDisabledLightColor = Color(0xFFB3C2E0);

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
        onSecondary: Colors.white,
        onSurface: textPrimaryLightColor,
      ),
      scaffoldBackgroundColor: backgroundLightColor,

      // AppBar Theme - Dark Mode - Light Mode
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLightColor,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: (normalFontSize + 4).sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 24.r),
      ),

      // Text Theme - Dark Mode - Light Mode
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryLightColor,
        textSecondaryLightColor,
      ),

      // Button Themes - Dark Mode - Light Mode
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLightColor,
          foregroundColor: Colors.white,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 2,
        ),
      ),

      // Card Theme - Dark Mode - Light Mode
      cardTheme: CardThemeData(
        color: surfaceLightColor,
        elevation: 2,
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),

      // Icon Theme - Dark Mode - Light Mode
      iconTheme: IconThemeData(
        color: primaryLightColor,
        size: 24.r,
        opacity: 1,
      ),

      // Divider Theme - Dark Mode - Light Mode
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
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundDarkColor,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceDarkColor,
        foregroundColor: textPrimaryDarkColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: (normalFontSize + 4).sp,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
        ),
        iconTheme: IconThemeData(color: primaryDarkColor, size: 24.r),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryDarkColor,
        textSecondaryDarkColor,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkColor,
          foregroundColor: Colors.white,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 4,
          shadowColor: primaryDarkColor.withAlpha((255 * 0.5).round()),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: surfaceDarkColor,
        elevation: 4,
        shadowColor: Colors.black.withAlpha((255 * 0.3).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
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

  // Helper method to get text style with Google Fonts
  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    // Sử dụng ScreenUtil để responsive font size
    final responsiveFontSize = fontSize.sp;
    TextStyle textStyle;

    switch (fontFamily) {
      case alternateFontFamily:
        textStyle = GoogleFonts.poppins(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case serifFontFamily:
        textStyle = GoogleFonts.merriweather(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case defaultFontFamily:
      default:
        textStyle = GoogleFonts.roboto(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
        );
    }

    return textStyle;
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
