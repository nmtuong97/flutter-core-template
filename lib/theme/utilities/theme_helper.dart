import 'package:flutter/material.dart';

import '../configurations/theme_configuration.dart';
import 'theme_utilities.dart';

/// Helper class for theme-specific operations
/// Provides common methods used across different theme builders
class ThemeHelper {
  const ThemeHelper._();

  // ==================== TEXT STYLE HELPERS ====================

  /// Create standardized text style with theme configuration
  static TextStyle createTextStyle({
    required ThemeConfiguration config,
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    List<Shadow>? shadows,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: config.fontFamily.primary,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? config.primaryTextColor,
      letterSpacing: letterSpacing ?? config.typography.letterSpacingScale,
      height: height ?? config.typography.lineHeightScale,
      shadows: shadows,
      decoration: decoration,
    );
  }

  /// Create text style with responsive sizing
  static TextStyle createResponsiveTextStyle({
    required ThemeConfiguration config,
    required double baseFontSize,
    required double screenWidth,
    FontWeight? fontWeight,
    Color? color,
    List<Shadow>? shadows,
  }) {
    final responsiveFontSize = ThemeUtilities.calculateResponsiveFontSize(
      baseFontSize: baseFontSize,
      screenWidth: screenWidth,
      scaleFactor: config.typography.fontSizeScale,
    );

    return createTextStyle(
      config: config,
      fontSize: responsiveFontSize,
      fontWeight: fontWeight,
      color: color,
      shadows: shadows,
    );
  }

  /// Create text style with theme-specific effects
  static TextStyle createThemedTextStyle({
    required ThemeConfiguration config,
    required String textType, // 'display', 'headline', 'title', 'body', 'label'
    required String size, // 'large', 'medium', 'small'
    Color? color,
    List<Shadow>? customShadows,
  }) {
    final fontSizes = ThemeUtilities.generateFontSizeHierarchy(
      baseFontSize: config.typography.baseFontSize,
      scaleRatio: config.typography.fontSizeScale,
    );

    final key =
        '$textType${size.substring(0, 1).toUpperCase()}${size.substring(1)}';
    final fontSize = fontSizes[key] ?? config.typography.baseFontSize;

    // Apply theme-specific shadows if not provided
    var shadows = customShadows;
    if (shadows == null &&
        config.typography.hasTextShadow &&
        config.typography.shadowColor != null) {
      shadows = [
        Shadow(
          color: config.typography.shadowColor!,
          offset: const Offset(1, 1),
          blurRadius: 2,
        ),
      ];
    }

    return createTextStyle(
      config: config,
      fontSize: fontSize,
      fontWeight: _getTextWeight(textType),
      color: color,
      shadows: shadows,
    );
  }

  /// Get appropriate font weight for text type
  static FontWeight _getTextWeight(String textType) {
    switch (textType.toLowerCase()) {
      case 'display':
        return FontWeight.w900;
      case 'headline':
        return FontWeight.w700;
      case 'title':
        return FontWeight.w600;
      case 'body':
        return FontWeight.w400;
      case 'label':
        return FontWeight.w500;
      default:
        return FontWeight.normal;
    }
  }

  // ==================== TEXT THEME HELPERS ====================

  /// Create complete text theme from configuration
  static TextTheme createTextTheme({
    required ThemeConfiguration config,
    double? screenWidth,
  }) {
    final fontSizes = ThemeUtilities.generateFontSizeHierarchy(
      baseFontSize: config.typography.baseFontSize,
      scaleRatio: config.typography.fontSizeScale,
    );

    // Helper function to create text style for each variant
    TextStyle createVariantStyle(
      String variant, {
      FontWeight? weight,
      Color? color,
    }) {
      final fontSize = fontSizes[variant] ?? config.typography.baseFontSize;

      if (screenWidth != null) {
        return createResponsiveTextStyle(
          config: config,
          baseFontSize: fontSize,
          screenWidth: screenWidth,
          fontWeight: weight,
          color: color,
        );
      }

      return createTextStyle(
        config: config,
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
      );
    }

    return TextTheme(
      displayLarge: createVariantStyle('displayLarge', weight: FontWeight.w900),
      displayMedium:
          createVariantStyle('displayMedium', weight: FontWeight.w800),
      displaySmall: createVariantStyle('displaySmall', weight: FontWeight.w700),
      headlineLarge:
          createVariantStyle('headlineLarge', weight: FontWeight.w700),
      headlineMedium:
          createVariantStyle('headlineMedium', weight: FontWeight.w600),
      headlineSmall:
          createVariantStyle('headlineSmall', weight: FontWeight.w600),
      titleLarge: createVariantStyle('titleLarge', weight: FontWeight.w600),
      titleMedium: createVariantStyle('titleMedium', weight: FontWeight.w500),
      titleSmall: createVariantStyle('titleSmall', weight: FontWeight.w500),
      bodyLarge: createVariantStyle('bodyLarge', weight: FontWeight.w400),
      bodyMedium: createVariantStyle('bodyMedium', weight: FontWeight.w400),
      bodySmall: createVariantStyle('bodySmall', weight: FontWeight.w400),
      labelLarge: createVariantStyle('labelLarge', weight: FontWeight.w500),
      labelMedium: createVariantStyle('labelMedium', weight: FontWeight.w500),
      labelSmall: createVariantStyle('labelSmall', weight: FontWeight.w500),
    );
  }

  // ==================== COMPONENT THEME HELPERS ====================

  /// Create app bar theme from configuration
  static AppBarTheme createAppBarTheme(ThemeConfiguration config) {
    return AppBarTheme(
      backgroundColor: config.surfaceColor,
      foregroundColor: config.primaryTextColor,
      elevation: config.components.elevation,
      centerTitle: true,
      titleTextStyle: createTextStyle(
        config: config,
        fontSize: config.typography.baseFontSize * 1.25,
        fontWeight: FontWeight.w600,
      ),
      toolbarTextStyle: createTextStyle(
        config: config,
        fontSize: config.typography.baseFontSize,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(config.components.borderRadius.topLeft.x),
        ),
      ),
    );
  }

  /// Create elevated button theme from configuration
  static ElevatedButtonThemeData createElevatedButtonTheme(
    ThemeConfiguration config,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: config.primaryColor,
        foregroundColor: config.primaryTextColor,
        elevation: config.components.elevation,
        padding: EdgeInsets.symmetric(
          horizontal: config.components.padding.horizontal * 2,
          vertical: config.components.padding.vertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: config.components.borderRadius,
        ),
        textStyle: createTextStyle(
          config: config,
          fontSize: config.typography.baseFontSize,
          fontWeight: FontWeight.w600,
        ),
        animationDuration: config.animations.normalDuration,
      ),
    );
  }

  /// Create card theme from configuration
  static CardThemeData createCardTheme(ThemeConfiguration config) {
    return CardThemeData(
      color: config.surfaceColor,
      elevation: config.components.elevation,
      margin: config.components.padding,
      shape: RoundedRectangleBorder(
        borderRadius: config.components.borderRadius,
      ),
      shadowColor: config.shadows.neonGlowColor ?? Colors.black,
    );
  }

  /// Create input decoration theme from configuration
  static InputDecorationTheme createInputDecorationTheme(
    ThemeConfiguration config,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: config.surfaceColor,
      border: OutlineInputBorder(
        borderRadius: config.components.borderRadius,
        borderSide: BorderSide(color: config.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: config.components.borderRadius,
        borderSide:
            BorderSide(color: config.primaryColor.withValues(alpha: 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: config.components.borderRadius,
        borderSide: BorderSide(color: config.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: config.components.borderRadius,
        borderSide: BorderSide(color: config.errorColor),
      ),
      contentPadding: config.components.padding,
      labelStyle: createTextStyle(
        config: config,
        fontSize: config.typography.baseFontSize,
        color: config.secondaryTextColor,
      ),
      hintStyle: createTextStyle(
        config: config,
        fontSize: config.typography.baseFontSize,
        color: config.secondaryTextColor.withValues(alpha: 0.7),
      ),
    );
  }

  // ==================== THEME VALIDATION HELPERS ====================

  /// Validate theme data consistency
  static List<String> validateThemeData(ThemeData themeData) {
    final errors = <String>[];

    // Check color scheme consistency
    if (themeData.colorScheme.primary == themeData.colorScheme.secondary) {
      errors.add('Primary and secondary colors should be different');
    }

    // Check text theme completeness
    if (themeData.textTheme.bodyMedium == null) {
      errors.add('Body medium text style is required');
    }

    // Check accessibility
    final contrastRatio = ThemeUtilities.calculateContrastRatio(
      themeData.colorScheme.onPrimary,
      themeData.colorScheme.primary,
    );

    if (contrastRatio < 4.5) {
      errors
          .add('Primary color contrast ratio is below accessibility standards');
    }

    return errors;
  }

  /// Performance check for theme creation
  static Map<String, dynamic> analyzeThemePerformance(ThemeData themeData) {
    final stopwatch = Stopwatch()..start();

    // Simulate theme usage
    final bodyMedium = themeData.textTheme.bodyMedium;
    final primaryColor = themeData.colorScheme.primary;
    final appBarColor = themeData.appBarTheme.backgroundColor;

    stopwatch.stop();

    return {
      'accessTime': stopwatch.elapsedMicroseconds,
      'isPerformant': stopwatch.elapsedMicroseconds < 1000, // Less than 1ms
      'textThemeSize': themeData.textTheme.toString().length,
      'colorSchemeSize': themeData.colorScheme.toString().length,
      'bodyMedium': bodyMedium?.fontSize ?? 0,
      'primaryColor': primaryColor.r.toInt() << 16 |
          primaryColor.g.toInt() << 8 |
          primaryColor.b.toInt(),
      'appBarColor': appBarColor?.toString() ?? 'null',
    };
  }
}
