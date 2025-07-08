import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../base/app_theme.dart';
import '../extensions/app_theme_extension.dart';

/// Theme mặc định của ứng dụng
class DefaultTheme extends AppTheme {
  @override
  String get id => 'default';

  @override
  String get name => 'Default';

  @override
  String get description => 'Standard Material Design';

  @override
  bool get isDefault => true;

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

  // Light Theme Colors
  static const Color primaryLightColor = Color(0xFF00CC7A); // xanh đậm
  static const Color secondaryLightColor = Color(0xFFE0E0E0);
  static const Color backgroundLightColor = Color(0xFFF5F5F5);
  static const Color surfaceLightColor = Colors.white;
  static const Color textPrimaryLightColor = Color(0xDD212121); // 87% opacity
  static const Color textSecondaryLightColor = Color(0x99757575); // 60% opacity
  static const Color textDisabledLightColor = Color(0x619E9E9E); // 38% opacity
  static const Color errorLightColor = Color(0xFFD32F2F);
  static const Color dividerLightColor = Color(0x1F000000); // 12% opacity

  // Dark Theme Colors
  static const Color primaryDarkColor = Color(0xFF00FF9D); // neon xanh
  static const Color secondaryDarkColor = Color(0xFF2D2D2D);
  static const Color backgroundDarkColor = Color(0xFF1A1A1A);
  static const Color surfaceDarkColor = Color(0xFF262626);
  static const Color textPrimaryDarkColor = Color(0xDDFFFFFF); // 87% opacity
  static const Color textSecondaryDarkColor = Color(0x99FFFFFF); // 60% opacity
  static const Color textDisabledDarkColor = Color(0x61FFFFFF); // 38% opacity
  static const Color errorDarkColor = Color(0xFFFF4D4D);
  static const Color dividerDarkColor = Color(0x1FFFFFFF); // 12% opacity

  @override
  ThemeData get lightThemeData {
    // Tạo AppThemeExtension cho light theme
    final appThemeExtension = AppThemeExtension.light();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLightColor,
      colorScheme: const ColorScheme.light(
        primary: primaryLightColor,
        secondary: secondaryLightColor,
        surface: backgroundLightColor,
        error: errorLightColor,
        onSecondary: textPrimaryLightColor,
        onSurface: textPrimaryLightColor,
      ),
      // Thêm extension vào theme
      extensions: [appThemeExtension],
      scaffoldBackgroundColor: backgroundLightColor,
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLightColor,
        foregroundColor: textPrimaryLightColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: (normalFontSize + 4).sp,
          fontWeight: FontWeight.bold,
          color: textPrimaryLightColor,
        ),
        iconTheme: IconThemeData(color: textPrimaryLightColor, size: 24.r),
        actionsIconTheme: IconThemeData(
          color: textPrimaryLightColor,
          size: 24.r,
        ),
        centerTitle: false,
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
      ),
      // Text Theme
      textTheme: _getTextTheme(
        defaultFontFamily,
        normalFontSize,
        textPrimaryLightColor,
        textSecondaryLightColor,
      ),
      // Button Themes
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 2,
          shadowColor: primaryLightColor.withAlpha((255 * 0.2).round()),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLightColor,
          side: const BorderSide(color: primaryLightColor),
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      // Card Theme
      cardTheme: CardTheme(
        color: surfaceLightColor,
        elevation: 1,
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.zero,
      ),
      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimaryLightColor,
        size: 24,
        opacity: 1,
      ),
      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: primaryLightColor,
        size: 24,
        opacity: 1,
      ),
    );
  }

  @override
  ThemeData get darkThemeData {
    // Tạo AppThemeExtension cho dark theme
    final appThemeExtension = AppThemeExtension.dark();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryDarkColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryDarkColor,
        secondary: secondaryDarkColor,
        surface: surfaceDarkColor,
        error: errorDarkColor,
        onSecondary: textPrimaryDarkColor,
        onSurface: textPrimaryDarkColor,
        onError: Colors.white,
      ),
      // Thêm extension vào theme
      extensions: [appThemeExtension],
      scaffoldBackgroundColor: backgroundDarkColor,
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDarkColor,
        foregroundColor: textPrimaryDarkColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: (normalFontSize + 4).sp,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
        ),
        iconTheme: IconThemeData(color: textPrimaryDarkColor, size: 24.r),
        actionsIconTheme: IconThemeData(
          color: textPrimaryDarkColor,
          size: 24.r,
        ),
        centerTitle: false,
        shadowColor: Colors.black.withAlpha((255 * 0.2).round()),
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
          foregroundColor: backgroundDarkColor,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
            color: backgroundDarkColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 2,
          shadowColor: primaryDarkColor.withAlpha((255 * 0.3).round()),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDarkColor,
          side: const BorderSide(color: primaryDarkColor),
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: normalFontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      // Card Theme
      cardTheme: CardTheme(
        color: surfaceDarkColor,
        elevation: 1,
        shadowColor: Colors.black.withAlpha((255 * 0.3).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.zero,
      ),
      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimaryDarkColor,
        size: 24,
        opacity: 1,
      ),
      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: primaryDarkColor,
        size: 24,
        opacity: 1,
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
        fontFamily: defaultFontFamily,
        fontSize: normalFontSize,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      bodyLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        color: primaryTextColor,
      ),
      bodyMedium: _getTextStyle(
        fontFamily: defaultFontFamily,
        fontSize: normalFontSize,
        color: primaryTextColor,
      ),
      bodySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 2,
        color: secondaryTextColor,
      ),
      labelLarge: _getTextStyle(
        fontFamily: defaultFontFamily,
        fontSize: normalFontSize,
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
