import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Cyberpunk theme implementation with neon colors and modern gradients.
class CyberpunkTheme {
  // Font sizes
  static const double smallFontSize = 12;
  static const double normalFontSize = 14;
  static const double mediumFontSize = 16;
  static const double largeFontSize = 18;
  static const double extraLargeFontSize = 22;

  // Base Colors - Dark Mode
  static const Color backgroundDarkColor = Color(0xFF0F0F13); // Xám không gian
  static const Color primaryDarkColor = Color(0xFFFF3BFF); // Neon hồng
  static const Color secondaryDarkColor = Color(0xFF00F0FF); // Xanh cyan
  static const Color accentDarkColor = Color(0xFFFFD600); // Vàng chanh
  static const Color surfaceDarkColor = Color(0xFF1A1A24); // Xám vũ trụ
  static const Color inactiveIconDarkColor = Color(0xFF4A4A5A);

  // Base Colors - Light Mode
  static const Color backgroundLightColor = Color(0xFFF8F9FF); // Trắng cosmic
  static const Color primaryLightColor = Color(0xFF00F0FF); // Neon xanh điện
  static const Color secondaryLightColor = Color(0xFFFF3BFF); // Hồng nhạt
  static const Color accentLightColor = Color(0xFFFF6B35); // Cam neon
  static const Color surfaceLightColor = Color(0xFFFFFFFF); // Trắng tinh
  static const Color inactiveIconLightColor = Color(0xFFB3B3C2);

  // Text Colors - Dark Mode
  static const Color textPrimaryDarkColor = Color(0xFFFFFFFF);
  static const Color textSecondaryDarkColor = Color(0xFFB3B3C2);
  static const Color textDisabledDarkColor = Color(0xFF4A4A5A);

  // Text Colors - Light Mode
  static const Color textPrimaryLightColor = Color(0xFF0F0F13);
  static const Color textSecondaryLightColor = Color(0xFF4A4A5A);
  static const Color textDisabledLightColor = Color(0xFFB3B3C2);

  // Font families
  static const String defaultFontFamily = 'Orbitron';
  static const String alternateFontFamily = 'Rajdhani';
  static const String serifFontFamily = 'Audiowide';

  /// Creates a cyberpunk dark theme.
  static ThemeData getDarkTheme({
    double fontSize = normalFontSize,
    String fontFamily = defaultFontFamily,
  }) {
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
          fontFamily: fontFamily,
          fontSize: fontSize + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
          hasShadow: true,
          shadowColor: primaryDarkColor,
        ),
        iconTheme: const IconThemeData(color: primaryDarkColor, size: 24),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        fontFamily,
        fontSize,
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
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: backgroundDarkColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 8,
          shadowColor: primaryDarkColor.withAlpha((255 * 0.4).round()),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDarkColor,
          side: const BorderSide(color: primaryDarkColor, width: 2),
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: primaryDarkColor,
            hasShadow: true,
            shadowColor: primaryDarkColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: secondaryDarkColor,
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: secondaryDarkColor,
            hasShadow: true,
            shadowColor: secondaryDarkColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: surfaceDarkColor,
        elevation: 8,
        shadowColor: primaryDarkColor.withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
             color: primaryDarkColor.withAlpha((255 * 0.3).round()),
           ),
        ),
        margin: const EdgeInsets.all(4),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceDarkColor,
        selectedItemColor: primaryDarkColor,
        unselectedItemColor: inactiveIconDarkColor,
        type: BottomNavigationBarType.fixed,
        elevation: 16,
        selectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          fontWeight: FontWeight.w500,
          color: primaryDarkColor,
          hasShadow: true,
          shadowColor: primaryDarkColor,
        ),
        unselectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: inactiveIconDarkColor,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryDarkColor,
        foregroundColor: backgroundDarkColor,
        elevation: 8,
        splashColor: secondaryDarkColor.withAlpha((255 * 0.3).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        enableFeedback: true,
        iconSize: 24,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceDarkColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryDarkColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryDarkColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: secondaryDarkColor, width: 2),
        ),
        hintStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textDisabledDarkColor,
        ),
        labelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: secondaryDarkColor,
          hasShadow: true,
          shadowColor: secondaryDarkColor.withAlpha((255 * 0.5).round()),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: surfaceDarkColor,
        elevation: 24,
        shadowColor: primaryDarkColor.withAlpha((255 * 0.3).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
             color: primaryDarkColor.withAlpha((255 * 0.3).round()),
           ),
        ),
        titleTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize + 2,
          fontWeight: FontWeight.bold,
          color: primaryDarkColor,
          hasShadow: true,
          shadowColor: primaryDarkColor,
        ),
        contentTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryDarkColor,
        ),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryDarkColor,
        inactiveTrackColor: inactiveIconDarkColor,
        thumbColor: secondaryDarkColor,
        overlayColor: primaryDarkColor.withAlpha((255 * 0.2).round()),
        valueIndicatorColor: primaryDarkColor,
        valueIndicatorTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: backgroundDarkColor,
        ),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryDarkColor,
        linearTrackColor: inactiveIconDarkColor,
        circularTrackColor: inactiveIconDarkColor,
        refreshBackgroundColor: surfaceDarkColor,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryDarkColor,
        size: 24,
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

  /// Creates a cyberpunk light theme.
  static ThemeData getLightTheme({
    double fontSize = normalFontSize,
    String fontFamily = defaultFontFamily,
  }) {
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
          fontFamily: fontFamily,
          fontSize: fontSize + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryLightColor,
          hasShadow: true,
          shadowColor: primaryLightColor,
        ),
        iconTheme: const IconThemeData(color: primaryLightColor, size: 24),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        fontFamily,
        fontSize,
        textPrimaryLightColor,
        textSecondaryLightColor,
        primaryLightColor,
        secondaryLightColor,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLightColor,
          foregroundColor: backgroundLightColor,
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: backgroundLightColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 8,
          shadowColor: primaryLightColor.withAlpha((255 * 0.3).round()),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLightColor,
          side: const BorderSide(color: primaryLightColor, width: 2),
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: primaryLightColor,
            hasShadow: true,
            shadowColor: primaryLightColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: secondaryLightColor,
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: secondaryLightColor,
            hasShadow: true,
            shadowColor: secondaryLightColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: surfaceLightColor,
        elevation: 8,
        shadowColor: primaryLightColor.withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
             color: primaryLightColor.withAlpha((255 * 0.3).round()),
           ),
        ),
        margin: const EdgeInsets.all(4),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceLightColor,
        selectedItemColor: primaryLightColor,
        unselectedItemColor: inactiveIconLightColor,
        type: BottomNavigationBarType.fixed,
        elevation: 16,
        selectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          fontWeight: FontWeight.w500,
          color: primaryLightColor,
          hasShadow: true,
          shadowColor: primaryLightColor,
        ),
        unselectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: inactiveIconLightColor,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLightColor,
        foregroundColor: backgroundLightColor,
        elevation: 8,
        splashColor: secondaryLightColor.withAlpha((255 * 0.3).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        enableFeedback: true,
        iconSize: 24,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceLightColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryLightColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryLightColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: secondaryLightColor, width: 2),
        ),
        hintStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textDisabledLightColor,
        ),
        labelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: secondaryLightColor,
          hasShadow: true,
          shadowColor: secondaryLightColor.withAlpha((255 * 0.5).round()),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: surfaceLightColor,
        elevation: 24,
        shadowColor: primaryLightColor.withAlpha((255 * 0.3).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
             color: primaryLightColor.withAlpha((255 * 0.3).round()),
           ),
        ),
        titleTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize + 2,
          fontWeight: FontWeight.bold,
          color: primaryLightColor,
          hasShadow: true,
          shadowColor: primaryLightColor,
        ),
        contentTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryLightColor,
        ),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryLightColor,
        inactiveTrackColor: inactiveIconLightColor,
        thumbColor: secondaryLightColor,
        overlayColor: primaryLightColor.withAlpha((255 * 0.2).round()),
        valueIndicatorColor: primaryLightColor,
        valueIndicatorTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: backgroundLightColor,
        ),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryLightColor,
        linearTrackColor: inactiveIconLightColor,
        circularTrackColor: inactiveIconLightColor,
        refreshBackgroundColor: surfaceLightColor,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryLightColor,
        size: 24,
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

  /// Helper method to get text style with optional neon shadow effect.
  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
    bool hasShadow = false,
    Color? shadowColor,
  }) {
    TextStyle textStyle;

    switch (fontFamily) {
      case alternateFontFamily:
        textStyle = GoogleFonts.rajdhani(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case serifFontFamily:
        textStyle = GoogleFonts.audiowide(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case defaultFontFamily:
      default:
        textStyle = GoogleFonts.orbitron(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
    }

    if (hasShadow && shadowColor != null) {
      return textStyle.copyWith(
        shadows: [
          Shadow(color: shadowColor, blurRadius: 8),
          Shadow(
             color: shadowColor.withAlpha((255 * 0.5).round()),
             blurRadius: 16,
           ),
        ],
      );
    }

    return textStyle;
  }

  /// Helper method to get text theme with cyberpunk styling.
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
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      displayMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 8,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      displaySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 6,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      headlineLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 10,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      headlineMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 6,
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
        color: primaryColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      titleMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        hasShadow: true,
        shadowColor: primaryColor,
      ),
      titleSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: primaryColor,
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
        color: secondaryColor,
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

  /// Creates a gradient button decoration for cyberpunk style.
  static BoxDecoration getGradientButtonDecoration({
    required bool isDarkMode,
    double borderRadius = 8.0,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDarkMode
            ? [primaryDarkColor, accentDarkColor]
            : [primaryLightColor, accentLightColor],
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: isDarkMode
              ? primaryDarkColor.withAlpha((255 * 0.4).round())
              : primaryLightColor.withAlpha((255 * 0.3).round()),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Creates a gradient text style for cyberpunk style.
  static TextStyle getGradientTextStyle({
    required bool isDarkMode,
    required String fontFamily,
    double fontSize = normalFontSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return _getTextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: isDarkMode ? Colors.white : Colors.black,
      hasShadow: true,
      shadowColor: isDarkMode ? primaryDarkColor : primaryLightColor,
    );
  }
}
