import 'package:flutter/material.dart';

/// Utility class để standardize method signatures và parameters
/// across all theme implementations để đảm bảo consistency
class ThemeStandardization {
  const ThemeStandardization._();

  /// Standard method signature cho _getTextStyle
  /// Tất cả themes phải follow signature này để đảm bảo consistency
  static TextStyle standardTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    bool hasShadow = false,
    Color? shadowColor,
    double? letterSpacing,
    double? height,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      shadows: hasShadow && shadowColor != null
          ? [
              Shadow(
                color: shadowColor,
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ]
          : null,
    );
  }

  /// Standard method signature cho _getTextTheme
  /// Tất cả themes phải follow signature này
  static TextTheme standardTextTheme({
    required String fontFamily,
    required double baseFontSize,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    Color? accentColor,
    Color? disabledColor,
    bool hasTextShadow = false,
    Color? shadowColor,
    double? letterSpacing,
  }) {
    return TextTheme(
      // Display styles - largest text
      displayLarge: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 12,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
        letterSpacing: letterSpacing,
      ),
      displayMedium: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 10,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
        letterSpacing: letterSpacing,
      ),
      displaySmall: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 8,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
        letterSpacing: letterSpacing,
      ),

      // Headline styles
      headlineLarge: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 6,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
        letterSpacing: letterSpacing,
      ),
      headlineMedium: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 5,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
        letterSpacing: letterSpacing,
      ),
      headlineSmall: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
        letterSpacing: letterSpacing,
      ),

      // Title styles
      titleLarge: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: letterSpacing,
      ),
      titleMedium: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 2,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: letterSpacing,
      ),
      titleSmall: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: letterSpacing,
      ),

      // Body styles
      bodyLarge: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 2,
        color: primaryTextColor,
        letterSpacing: letterSpacing,
      ),
      bodyMedium: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize,
        color: primaryTextColor,
        letterSpacing: letterSpacing,
      ),
      bodySmall: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize - 2,
        color: secondaryTextColor,
        letterSpacing: letterSpacing,
      ),

      // Label styles
      labelLarge: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize,
        fontWeight: FontWeight.w500,
        color: accentColor ?? primaryTextColor,
        letterSpacing: letterSpacing,
      ),
      labelMedium: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize - 1,
        fontWeight: FontWeight.w500,
        color: accentColor ?? secondaryTextColor,
        letterSpacing: letterSpacing,
      ),
      labelSmall: standardTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize - 2,
        fontWeight: FontWeight.w500,
        color: accentColor ?? secondaryTextColor,
        letterSpacing: letterSpacing,
      ),
    );
  }

  /// Standard method signature cho ColorScheme creation
  static ColorScheme standardColorScheme({
    required Brightness brightness,
    required Color primary,
    required Color secondary,
    required Color surface,
    required Color background,
    required Color error,
    Color? onPrimary,
    Color? onSecondary,
    Color? onSurface,
    Color? onBackground,
    Color? onError,
    Color? tertiary,
    Color? onTertiary,
    Color? outline,
    Color? shadow,
  }) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary ?? _getContrastColor(primary),
      secondary: secondary,
      onSecondary: onSecondary ?? _getContrastColor(secondary),
      tertiary: tertiary ?? secondary,
      onTertiary: onTertiary ?? _getContrastColor(tertiary ?? secondary),
      error: error,
      onError: onError ?? _getContrastColor(error),
      surface: surface,
      onSurface: onSurface ?? _getContrastColor(surface),
      outline: outline ?? _getContrastColor(surface).withValues(alpha: 0.38),
      shadow: shadow ?? Colors.black,
    );
  }

  /// Standard method signature cho AppBarTheme
  static AppBarTheme standardAppBarTheme({
    required Color backgroundColor,
    required Color foregroundColor,
    required TextStyle titleTextStyle,
    double elevation = 0,
    bool centerTitle = false,
    Color? shadowColor,
    Color? surfaceTintColor,
  }) {
    return AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      titleTextStyle: titleTextStyle,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      iconTheme: IconThemeData(
        color: foregroundColor,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: foregroundColor,
        size: 24,
      ),
    );
  }

  /// Standard method signature cho ElevatedButtonTheme
  static ElevatedButtonThemeData standardElevatedButtonTheme({
    required Color backgroundColor,
    required Color foregroundColor,
    required TextStyle textStyle,
    double elevation = 2,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    Color? shadowColor,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
        textStyle: textStyle,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Standard method signature cho OutlinedButtonTheme
  static OutlinedButtonThemeData standardOutlinedButtonTheme({
    required Color foregroundColor,
    required Color borderColor,
    required TextStyle textStyle,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    double borderWidth = 1,
  }) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
        textStyle: textStyle,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Standard method signature cho TextButtonTheme
  static TextButtonThemeData standardTextButtonTheme({
    required Color foregroundColor,
    required TextStyle textStyle,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
  }) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
        textStyle: textStyle,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Standard method signature cho CardTheme
  static CardThemeData standardCardTheme({
    required Color color,
    required Color shadowColor,
    double elevation = 1,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    Clip clipBehavior = Clip.none,
  }) {
    return CardThemeData(
      color: color,
      shadowColor: shadowColor,
      elevation: elevation,
      margin: margin ?? const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      clipBehavior: clipBehavior,
    );
  }

  /// Standard method signature cho InputDecorationTheme
  static InputDecorationTheme standardInputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
    required Color focusedBorderColor,
    required Color errorBorderColor,
    required TextStyle hintStyle,
    required TextStyle labelStyle,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    bool filled = true,
  }) {
    final radius = borderRadius ?? BorderRadius.circular(8);
    return InputDecorationTheme(
      filled: filled,
      fillColor: fillColor,
      hintStyle: hintStyle,
      labelStyle: labelStyle,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: focusedBorderColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: errorBorderColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: errorBorderColor, width: 2),
      ),
    );
  }

  /// Helper method để tính contrast color
  static Color _getContrastColor(Color color) {
    // Calculate luminance
    final luminance = color.computeLuminance();

    // Return black or white based on luminance
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

/// Validation utility để check method signature consistency
class ThemeConsistencyValidator {
  const ThemeConsistencyValidator._();

  /// Validate rằng tất cả themes follow standard signatures
  static List<String> validateThemeConsistency() {
    // Check for common inconsistencies and collect all issues
    return [
      ..._validateTextStyleSignatures(),
      ..._validateTextThemeSignatures(),
      ..._validateComponentThemeSignatures(),
    ];
  }

  static List<String> _validateTextStyleSignatures() {
    final issues = <String>[];

    // TODO(theme): Implement actual validation logic
    // Đây sẽ là nơi check actual theme files

    return issues;
  }

  static List<String> _validateTextThemeSignatures() {
    final issues = <String>[];

    // TODO(theme): Implement actual validation logic

    return issues;
  }

  static List<String> _validateComponentThemeSignatures() {
    final issues = <String>[];

    // Kiểm tra consistency trong component theme methods
    // TODO(theme): Implement validation for AppBar, Button, Card themes

    return issues;
  }

  /// Generate migration suggestions
  static List<String> generateMigrationSuggestions() {
    return [
      'Replace _getTextStyle với ThemeStandardization.standardTextStyle',
      'Replace _getTextTheme với ThemeStandardization.standardTextTheme',
      'Standardize tất cả component theme methods',
      'Add missing parameters để match standard signatures',
      'Remove deprecated parameters không còn sử dụng',
    ];
  }
}
