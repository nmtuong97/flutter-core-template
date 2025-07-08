import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_theme_showcase/theme/base/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme Neumorphism với hiệu ứng nổi 3D mềm mại
class NeumorphismTheme extends AppTheme {
  @override
  String get id => 'neumorphism';

  @override
  String get name => 'Neumorphism';

  @override
  String get description => 'Hiệu ứng nổi 3D mềm mại';

  // Font sizes
  static const double smallFontSize = 12;
  static const double normalFontSize = 14;
  static const double mediumFontSize = 16;
  static const double largeFontSize = 18;
  static const double extraLargeFontSize = 22;

  // Font families
  static const String defaultFontFamily = 'Poppins';
  static const String alternateFontFamily = 'Montserrat';
  static const String serifFontFamily = 'Merriweather';

  // Base Colors - Light Mode (màu nhẹ nhàng cho hiệu ứng nổi)
  static const Color backgroundLightColor = Color(0xFFE0E5EC); // Xám nhạt
  static const Color primaryLightColor = Color(0xFF4B70E2); // Xanh dương
  static const Color secondaryLightColor = Color(0xFF8E9AAF); // Xám xanh
  static const Color accentLightColor = Color(0xFF6C63FF); // Tím nhạt
  static const Color surfaceLightColor = Color(0xFFE0E5EC); // Giống background
  static const Color shadowDarkLightColor = Color(0xFFA3B1C6); // Bóng đậm
  static const Color shadowLightLightColor = Color(0xFFFFFFFF); // Bóng sáng

  // Base Colors - Dark Mode
  static const Color backgroundDarkColor = Color(0xFF2D3748); // Xám đậm
  static const Color primaryDarkColor = Color(0xFF6C63FF); // Tím nhạt
  static const Color secondaryDarkColor = Color(0xFF718096); // Xám trung
  static const Color accentDarkColor = Color(0xFF4B70E2); // Xanh dương
  static const Color surfaceDarkColor = Color(0xFF2D3748); // Giống background
  static const Color shadowDarkDarkColor = Color(0xFF1A202C); // Bóng đậm
  static const Color shadowLightDarkColor = Color(0xFF4A5568); // Bóng sáng

  // Text Colors - Light Mode
  static const Color textPrimaryLightColor = Color(0xFF2D3748);
  static const Color textSecondaryLightColor = Color(0xFF718096);
  static const Color textDisabledLightColor = Color(0xFFA0AEC0);

  // Text Colors - Dark Mode
  static const Color textPrimaryDarkColor = Color(0xFFE2E8F0);
  static const Color textSecondaryDarkColor = Color(0xFFA0AEC0);
  static const Color textDisabledDarkColor = Color(0xFF718096);

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

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLightColor,
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

      // Text Theme
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryLightColor,
        textSecondaryLightColor,
      ),

      // Button Themes - với hiệu ứng neumorphic
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: surfaceLightColor,
          foregroundColor: primaryLightColor,
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
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ).copyWith(
          // Hiệu ứng neumorphic với BoxDecoration
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
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
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
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
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

      // Card Theme - với hiệu ứng neumorphic
      cardTheme: CardTheme(
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
          fontFamily: defaultFontFamily,
          fontSize: normalFontSize + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
        ),
        iconTheme: const IconThemeData(
          color: textPrimaryDarkColor,
        ),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryDarkColor,
        textSecondaryDarkColor,
      ),

      // Button Themes - với hiệu ứng neumorphic
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: surfaceDarkColor,
          foregroundColor: primaryDarkColor,
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
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ).copyWith(
          // Hiệu ứng neumorphic với BoxDecoration
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
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
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
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
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

      // Card Theme - với hiệu ứng neumorphic
      cardTheme: CardTheme(
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
    // Sử dụng ScreenUtil để responsive font size
    final responsiveFontSize = fontSize.sp;
    TextStyle textStyle;

    switch (fontFamily) {
      case alternateFontFamily:
        textStyle = GoogleFonts.montserrat(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: 0.2,
        );
      case serifFontFamily:
        textStyle = GoogleFonts.merriweather(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case defaultFontFamily:
      default:
        textStyle = GoogleFonts.poppins(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: 0.2,
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
