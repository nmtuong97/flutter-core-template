import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../base/app_theme.dart';

/// Retro/Vintage Theme with a nostalgic style
class RetroVintageTheme extends AppTheme {
  @override
  String get id => 'retro_vintage';

  @override
  String get name => 'Retro/Vintage';

  @override
  String get description =>
      'Phong cách hoài cổ với màu sắc và font chữ cổ điển';

  // Font sizes
  static const double smallFontSize = 12;
  static const double normalFontSize = 14;
  static const double mediumFontSize = 16;
  static const double largeFontSize = 18;
  static const double extraLargeFontSize = 22;

  // Font families - sử dụng font chữ cổ điển
  static const String defaultFontFamily = 'Playfair Display';
  static const String alternateFontFamily = 'Abril Fatface';
  static const String serifFontFamily = 'Lora';

  // Base Colors - Light Mode (màu vintage)
  static const Color backgroundLightColor = Color(0xFFF8F3E6); // Old paper color
  static const Color primaryLightColor = Color(0xFF8B4513); // Reddish brown
  static const Color secondaryLightColor = Color(0xFF5F9EA0); // Vintage teal
  static const Color accentLightColor = Color(0xFFCD5C5C); // Brick red
  static const Color surfaceLightColor = Color(0xFFF5EBD8); // Light paper color
  static const Color borderLightColor = Color(0xFFD2B48C); // Sand color

  // Base Colors - Dark Mode
  static const Color backgroundDarkColor = Color(0xFF2C2416); // Dark brown
  static const Color primaryDarkColor = Color(0xFFD2B48C); // Sand color
  static const Color secondaryDarkColor = Color(0xFF5F9EA0); // Vintage teal
  static const Color accentDarkColor = Color(0xFFCD5C5C); // Brick red
  static const Color surfaceDarkColor = Color(0xFF3C3022); // Darker brown
  static const Color borderDarkColor = Color(0xFF8B4513); // Reddish brown

  // Text Colors - Light Mode
  static const Color textPrimaryLightColor = Color(0xFF3C3022);
  static const Color textSecondaryLightColor = Color(0xFF6B5B3E);
  static const Color textDisabledLightColor = Color(0xFFA99D86);

  // Text Colors - Dark Mode
  static const Color textPrimaryDarkColor = Color(0xFFF5EBD8);
  static const Color textSecondaryDarkColor = Color(0xFFD2B48C);
  static const Color textDisabledDarkColor = Color(0xFF8B7355);

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
        error: Color(0xFFCD5C5C), // Brick red
        onSecondary: Colors.white,
        onSurface: textPrimaryLightColor,
      ),
      scaffoldBackgroundColor: backgroundLightColor,

      // AppBar Theme - phong cách cổ điển
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

      // Text Theme - font chữ cổ điển
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryLightColor,
        textSecondaryLightColor,
      ),

      // Button Themes - phong cách cổ điển
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
            borderRadius: BorderRadius.circular(8.r),
            side: const BorderSide(
              color: borderLightColor,
            ),
          ),
          elevation: 2,
          shadowColor: Colors.black.withAlpha((255 * 0.2).round()),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLightColor,
          side: const BorderSide(
            color: primaryLightColor,
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
            borderRadius: BorderRadius.circular(8.r),
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
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),

      // Card Theme - phong cách cổ điển
      cardTheme: CardThemeData(
        color: surfaceLightColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: const BorderSide(
            color: borderLightColor,
          ),
        ),
        margin: EdgeInsets.all(8.r),
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
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

      // Input Decoration - phong cách cổ điển
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLightColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: borderLightColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: borderLightColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: primaryLightColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
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
        error: Color(0xFFCD5C5C), // Brick red
        onPrimary: Color(0xFF3C3022), // Dark brown
        onSecondary: Color(0xFF3C3022), // Dark brown
        onSurface: textPrimaryDarkColor,
      ),
      scaffoldBackgroundColor: backgroundDarkColor,

      // AppBar Theme - phong cách cổ điển
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

      // Text Theme - font chữ cổ điển
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryDarkColor,
        textSecondaryDarkColor,
      ),

      // Button Themes - phong cách cổ điển
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkColor,
          foregroundColor: const Color(0xFF3C3022), // Dark brown
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3C3022), // Dark brown
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: const BorderSide(
              color: borderDarkColor,
            ),
          ),
          elevation: 2,
          shadowColor: Colors.black.withAlpha((255 * 0.3).round()),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDarkColor,
          side: const BorderSide(
            color: primaryDarkColor,
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
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDarkColor,
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
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),

      // Card Theme - phong cách cổ điển
      cardTheme: CardThemeData(
        color: surfaceDarkColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: const BorderSide(
            color: borderDarkColor,
          ),
        ),
        margin: EdgeInsets.all(8.r),
        shadowColor: Colors.black.withAlpha((255 * 0.2).round()),
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

      // Input Decoration - phong cách cổ điển
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDarkColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: borderDarkColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: borderDarkColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: primaryDarkColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
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
  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    // Use ScreenUtil for responsive font sizing
    final responsiveFontSize = fontSize.sp;
    TextStyle textStyle;

    switch (fontFamily) {
      case alternateFontFamily:
        textStyle = GoogleFonts.abrilFatface(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: 0.5,
        );
      case serifFontFamily:
        textStyle = GoogleFonts.lora(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: 0.2,
        );
      case defaultFontFamily:
      default:
        textStyle = GoogleFonts.playfairDisplay(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: 0.3,
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
        fontFamily: alternateFontFamily, // Use different font for large titles
        fontSize: fontSize + 12,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displayMedium: _getTextStyle(
        fontFamily: alternateFontFamily, // Use different font for large titles
        fontSize: fontSize + 10,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displaySmall: _getTextStyle(
        fontFamily: alternateFontFamily, // Use different font for large titles
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
        fontFamily: serifFontFamily, // Use serif font for content
        fontSize: fontSize + 2,
        color: primaryTextColor,
      ),
      bodyMedium: _getTextStyle(
        fontFamily: serifFontFamily, // Use serif font for content
        fontSize: fontSize,
        color: primaryTextColor,
      ),
      bodySmall: _getTextStyle(
        fontFamily: serifFontFamily, // Use serif font for content
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
