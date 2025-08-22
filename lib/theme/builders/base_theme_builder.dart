import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';
import '../typography/theme_typography.dart';

/// Font size increment configuration for text hierarchy
class FontSizeIncrement {
  const FontSizeIncrement._();

  static const double displayLarge = 12;
  static const double displayMedium = 10;
  static const double displaySmall = 8;
  static const double headlineLarge = 6;
  static const double headlineMedium = 5;
  static const double headlineSmall = 4;
  static const double titleLarge = 4;
  static const double titleMedium = 2;
  static const double titleSmall = 0;
  static const double bodyLarge = 2;
  static const double bodyMedium = 0;
  static const double bodySmall = -2;
  static const double labelLarge = 0;
  static const double labelMedium = -1;
  static const double labelSmall = -2;
}

/// Abstract base class for theme builders
/// Provides common functionality to eliminate code duplication
/// Follows DRY principle and provides consistent theme building
abstract class BaseThemeBuilder {
  /// Get typography instance for the theme
  ThemeTypography get typography;

  /// Build a text style with consistent parameters
  ///
  /// This method centralizes text style creation to ensure consistency
  /// across all themes and eliminate duplication
  TextStyle buildTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    bool hasShadow = false,
    Color? shadowColor,
    double? letterSpacing,
  }) {
    return typography.getTextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      hasShadow: hasShadow,
      shadowColor: shadowColor,
      letterSpacing: letterSpacing,
    );
  }

  /// Build a complete text theme with consistent sizing and styling
  ///
  /// This method provides a standardized way to create TextTheme
  /// with proper font size scaling and color application
  TextTheme buildTextTheme({
    required String fontFamily,
    required double baseFontSize,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    Color? accentColor,
    bool hasTextShadow = false,
    Color? shadowColor,
  }) {
    return TextTheme(
      // Display styles - largest text
      displayLarge: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.displayLarge,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
      ),
      displayMedium: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.displayMedium,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
      ),
      displaySmall: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.displaySmall,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
      ),

      // Headline styles
      headlineLarge: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.headlineLarge,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
      ),
      headlineMedium: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.headlineMedium,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
      ),
      headlineSmall: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.headlineSmall,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        hasShadow: hasTextShadow,
        shadowColor: shadowColor,
      ),

      // Title styles
      titleLarge: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.titleLarge,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleMedium: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.titleMedium,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleSmall: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.titleSmall,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),

      // Body styles
      bodyLarge: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.bodyLarge,
        color: primaryTextColor,
      ),
      bodyMedium: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize,
        color: primaryTextColor,
      ),
      bodySmall: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.bodySmall,
        color: secondaryTextColor,
      ),

      // Label styles
      labelLarge: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize,
        fontWeight: FontWeight.w500,
        color: accentColor ?? primaryTextColor,
      ),
      labelMedium: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.labelMedium,
        fontWeight: FontWeight.w500,
        color: accentColor ?? secondaryTextColor,
      ),
      labelSmall: buildTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + FontSizeIncrement.labelSmall,
        fontWeight: FontWeight.w500,
        color: accentColor ?? secondaryTextColor,
      ),
    );
  }

  /// Build color scheme with consistent color application
  ColorScheme buildColorScheme({
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
  }) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary ?? _getContrastColor(primary),
      secondary: secondary,
      onSecondary: onSecondary ?? _getContrastColor(secondary),
      error: error,
      onError: onError ?? _getContrastColor(error),
      surface: surface,
      onSurface: onSurface ?? _getContrastColor(surface),
    );
  }

  /// Get appropriate contrast color (black or white) for given background
  Color _getContrastColor(Color backgroundColor) {
    // Calculate luminance to determine if we need light or dark text
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Build app bar theme with consistent styling
  AppBarTheme buildAppBarTheme({
    required Color backgroundColor,
    required Color foregroundColor,
    required TextStyle titleTextStyle,
    double elevation = ThemeConstants.elevationLow,
    bool centerTitle = true,
  }) {
    return AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      titleTextStyle: titleTextStyle,
      iconTheme: IconThemeData(color: foregroundColor),
      actionsIconTheme: IconThemeData(color: foregroundColor),
    );
  }

  /// Build elevated button theme with consistent styling
  ElevatedButtonThemeData buildElevatedButtonTheme({
    required Color backgroundColor,
    required Color foregroundColor,
    required TextStyle textStyle,
    double elevation = ThemeConstants.elevationMedium,
    EdgeInsets? padding,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
        padding: padding ?? ThemeConstants.mediumPadding,
        textStyle: textStyle,
        shape: RoundedRectangleBorder(
          borderRadius: ThemeConstants.mediumRadius,
        ),
      ),
    );
  }

  /// Build input decoration theme with consistent styling
  InputDecorationTheme buildInputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
    required Color focusedBorderColor,
    required Color errorBorderColor,
    required TextStyle hintStyle,
    required TextStyle labelStyle,
    BorderRadius? borderRadius,
  }) {
    final radius = borderRadius ?? ThemeConstants.mediumRadius;
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: hintStyle,
      labelStyle: labelStyle,
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
}
