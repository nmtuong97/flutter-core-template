import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_theme_showcase/theme/base/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme Exaggerated Minimalism với thiết kế tối giản nâng cấp
class ExaggeratedMinimalismTheme extends AppTheme {
  @override
  String get id => 'exaggerated_minimalism';

  @override
  String get name => 'Exaggerated Minimalism';

  @override
  String get description => 'Minimalism phá cách với tỷ lệ phóng đại';

  // Font sizes - phóng đại hơn so với theme thông thường
  static const double smallFontSize = 14;
  static const double normalFontSize = 18;
  static const double mediumFontSize = 24;
  static const double largeFontSize = 32;
  static const double extraLargeFontSize = 48;

  // Font families - sử dụng font geometric
  static const String defaultFontFamily = 'Inter';
  static const String alternateFontFamily = 'Space Grotesk';
  static const String serifFontFamily = 'Merriweather';

  // Base Colors - Light Mode (tối giản với tương phản cao)
  static const Color backgroundLightColor = Colors.white;
  static const Color primaryLightColor = Color(0xFF000000); // Đen
  static const Color secondaryLightColor = Color(0xFF333333); // Xám đậm
  static const Color accentLightColor = Color(0xFFFF6B35); // Cam neon
  static const Color surfaceLightColor = Color(0xFFF8F8F8); // Xám nhạt
  static const Color inactiveIconLightColor = Color(0xFFCCCCCC);

  // Base Colors - Dark Mode (tối giản với tương phản cao)
  static const Color backgroundDarkColor = Color(0xFF000000); // Đen
  static const Color primaryDarkColor = Color(0xFFFFFFFF); // Trắng
  static const Color secondaryDarkColor = Color(0xFFEEEEEE); // Xám nhạt
  static const Color accentDarkColor = Color(0xFFFF6B35); // Cam neon
  static const Color surfaceDarkColor = Color(0xFF111111); // Xám đậm
  static const Color inactiveIconDarkColor = Color(0xFF444444);

  // Text Colors - Light Mode
  static const Color textPrimaryLightColor = Color(0xFF000000);
  static const Color textSecondaryLightColor = Color(0xFF666666);
  static const Color textDisabledLightColor = Color(0xFFCCCCCC);

  // Text Colors - Dark Mode
  static const Color textPrimaryDarkColor = Color(0xFFFFFFFF);
  static const Color textSecondaryDarkColor = Color(0xFFCCCCCC);
  static const Color textDisabledDarkColor = Color(0xFF666666);

  @override
  ThemeData get lightThemeData {
    // Tăng kích thước font lên 1.5 lần để phù hợp với Exaggerated Minimalism
    const adjustedFontSize = normalFontSize * 1.5;

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
      ),
      scaffoldBackgroundColor: backgroundLightColor,

      // AppBar Theme - tối giản, không có đường viền
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLightColor,
        foregroundColor: textPrimaryLightColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: (adjustedFontSize + 8).sp,
          fontWeight: FontWeight.bold,
          color: textPrimaryLightColor,
        ),
        iconTheme: IconThemeData(
          color: textPrimaryLightColor,
          size: 32.r, // Icon lớn hơn
        ),
        centerTitle: true, // Căn giữa tiêu đề
      ),

      // Text Theme - kích thước lớn, khoảng cách dòng rộng
      textTheme: _getTextTheme(
        defaultFontFamily,
        adjustedFontSize,
        textPrimaryLightColor,
        textSecondaryLightColor,
      ),

      // Button Themes - nút lớn, viền tròn nhẹ
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLightColor,
          foregroundColor: Colors.white,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: adjustedFontSize + 4,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 20.h,
          ), // Padding lớn
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0, // Không có đổ bóng
          minimumSize: Size(200.w, 60.h), // Kích thước tối thiểu lớn
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLightColor,
          side: const BorderSide(width: 2), // Viền đậm
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: adjustedFontSize + 4,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 20.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          minimumSize: Size(200.w, 60.h),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLightColor,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: adjustedFontSize + 4,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 20.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          minimumSize: Size(200.w, 60.h),
        ),
      ),

      // Card Theme - viền tròn lớn, không đổ bóng
      cardTheme: CardTheme(
        color: surfaceLightColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r), // Viền tròn lớn
        ),
        margin: EdgeInsets.all(16.r), // Margin lớn
      ),

      // Icon Theme - icon lớn
      iconTheme: IconThemeData(
        color: primaryLightColor,
        size: 32.r, // Icon lớn
        opacity: 1,
      ),

      // Divider Theme - đường kẻ mỏng
      dividerTheme: const DividerThemeData(
        color: Color(0xFFEEEEEE),
        thickness: 1,
        space: 32, // Khoảng cách lớn
      ),

      // Input Decoration - input lớn, tối giản
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLightColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: accentLightColor, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 20.h,
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
    // Tăng kích thước font lên 1.5 lần để phù hợp với Exaggerated Minimalism
    const adjustedFontSize = normalFontSize * 1.5;

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
      ),
      scaffoldBackgroundColor: backgroundDarkColor,

      // AppBar Theme - tối giản, không có đường viền
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDarkColor,
        foregroundColor: textPrimaryDarkColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: defaultFontFamily,
          fontSize: (adjustedFontSize + 8).sp,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
        ),
        iconTheme: IconThemeData(
          color: textPrimaryDarkColor,
          size: 32.r, // Icon lớn hơn
        ),
        centerTitle: true, // Căn giữa tiêu đề
      ),

      // Text Theme - kích thước lớn, khoảng cách dòng rộng
      textTheme: _getTextTheme(
        defaultFontFamily,
        adjustedFontSize,
        textPrimaryDarkColor,
        textSecondaryDarkColor,
      ),

      // Button Themes - nút lớn, viền tròn nhẹ
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkColor,
          foregroundColor: Colors.black,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: adjustedFontSize + 4,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 20.h,
          ), // Padding lớn
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0, // Không có đổ bóng
          minimumSize: Size(200.w, 60.h), // Kích thước tối thiểu lớn
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDarkColor,
          side: const BorderSide(color: primaryDarkColor, width: 2), // Viền đậm
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: adjustedFontSize + 4,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 20.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          minimumSize: Size(200.w, 60.h),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDarkColor,
          textStyle: _getTextStyle(
            fontFamily: defaultFontFamily,
            fontSize: adjustedFontSize + 4,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
            vertical: 20.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          minimumSize: Size(200.w, 60.h),
        ),
      ),

      // Card Theme - viền tròn lớn, không đổ bóng
      cardTheme: CardTheme(
        color: surfaceDarkColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r), // Viền tròn lớn
        ),
        margin: EdgeInsets.all(16.r), // Margin lớn
      ),

      // Icon Theme - icon lớn
      iconTheme: IconThemeData(
        color: primaryDarkColor,
        size: 32.r, // Icon lớn
        opacity: 1,
      ),

      // Divider Theme - đường kẻ mỏng
      dividerTheme: const DividerThemeData(
        color: Color(0xFF333333),
        thickness: 1,
        space: 32, // Khoảng cách lớn
      ),

      // Input Decoration - input lớn, tối giản
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDarkColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: accentDarkColor, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 20.h,
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
        textStyle = GoogleFonts.spaceGrotesk(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
          height: 1.5, // Khoảng cách dòng lớn hơn
          letterSpacing: 0.5, // Khoảng cách chữ rộng hơn
        );
      case serifFontFamily:
        textStyle = GoogleFonts.merriweather(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
          height: 1.5,
          letterSpacing: 0.5,
        );
      case defaultFontFamily:
      default:
        textStyle = GoogleFonts.inter(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
          height: 1.5,
          letterSpacing: 0.5,
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
        fontSize: fontSize + 24, // Kích thước lớn hơn nhiều
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displayMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 20,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displaySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 16,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 12,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 10,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 8,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 8,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      bodyLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 4,
        color: primaryTextColor,
      ),
      bodyMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        color: primaryTextColor,
      ),
      bodySmall: _getTextStyle(
        fontFamily: defaultFontFamily,
        fontSize: normalFontSize,
        color: secondaryTextColor,
      ),
      labelLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      labelMedium: _getTextStyle(
        fontFamily: defaultFontFamily,
        fontSize: normalFontSize,
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
