import 'package:flutter/material.dart';

import '../configurations/theme_configuration.dart';
import '../constants/theme_constants.dart';

/// Utility class for common theme operations
/// Centralizes shared functionality to eliminate code duplication
class ThemeUtilities {
  const ThemeUtilities._();

  // ==================== COLOR UTILITIES ====================

  /// Create a color scheme from theme configuration
  static ColorScheme createColorScheme({
    required ThemeConfiguration config,
    required Brightness brightness,
  }) {
    return ColorScheme.fromSeed(
      seedColor: config.primaryColor,
      brightness: brightness,
      primary: config.primaryColor,
      secondary: config.secondaryColor,
      surface: config.surfaceColor,
      error: config.errorColor,
    );
  }

  /// Generate harmonious color palette from base color
  static Map<String, Color> generateColorPalette(Color baseColor) {
    final hsl = HSLColor.fromColor(baseColor);

    return {
      'primary': baseColor,
      'primaryLight':
          hsl.withLightness((hsl.lightness + 0.2).clamp(0.0, 1.0)).toColor(),
      'primaryDark':
          hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0)).toColor(),
      'accent': hsl.withHue((hsl.hue + 30) % 360).toColor(),
      'complement': hsl.withHue((hsl.hue + 180) % 360).toColor(),
      'analogous1': hsl.withHue((hsl.hue + 30) % 360).toColor(),
      'analogous2': hsl.withHue((hsl.hue - 30) % 360).toColor(),
    };
  }

  /// Apply opacity to color with validation
  static Color applyOpacity(Color color, double opacity) {
    assert(
      opacity >= 0.0 && opacity <= 1.0,
      'Opacity must be between 0.0 and 1.0',
    );
    return color.withValues(alpha: opacity);
  }

  /// Check color contrast ratio for accessibility
  static double calculateContrastRatio(Color foreground, Color background) {
    final foregroundLuminance = foreground.computeLuminance();
    final backgroundLuminance = background.computeLuminance();

    final lighter = foregroundLuminance > backgroundLuminance
        ? foregroundLuminance
        : backgroundLuminance;
    final darker = foregroundLuminance > backgroundLuminance
        ? backgroundLuminance
        : foregroundLuminance;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Validate color accessibility
  static bool isAccessible(
    Color foreground,
    Color background, {
    double minRatio = 4.5,
  }) {
    return calculateContrastRatio(foreground, background) >= minRatio;
  }

  // ==================== TYPOGRAPHY UTILITIES ====================

  /// Calculate responsive font size based on screen size
  static double calculateResponsiveFontSize({
    required double baseFontSize,
    required double screenWidth,
    double minFontSize = 12.0,
    double maxFontSize = 32.0,
    double scaleFactor = 1.0,
  }) {
    // Base calculation on screen width
    var calculatedSize = baseFontSize * scaleFactor;

    // Apply screen width adjustments
    if (screenWidth < 360) {
      calculatedSize *= 0.9; // Smaller screens
    } else if (screenWidth > 768) {
      calculatedSize *= 1.1; // Larger screens
    }

    // Clamp to min/max values
    return calculatedSize.clamp(minFontSize, maxFontSize);
  }

  /// Generate text theme hierarchy with consistent scaling
  static Map<String, double> generateFontSizeHierarchy({
    required double baseFontSize,
    double scaleRatio = 1.25, // Major third scale
  }) {
    return {
      'displayLarge':
          baseFontSize * scaleRatio * scaleRatio * scaleRatio * scaleRatio,
      'displayMedium': baseFontSize * scaleRatio * scaleRatio * scaleRatio,
      'displaySmall': baseFontSize * scaleRatio * scaleRatio,
      'headlineLarge': baseFontSize * scaleRatio * scaleRatio,
      'headlineMedium': baseFontSize * scaleRatio,
      'headlineSmall': baseFontSize,
      'titleLarge': baseFontSize,
      'titleMedium': baseFontSize / scaleRatio,
      'titleSmall': baseFontSize / scaleRatio,
      'bodyLarge': baseFontSize,
      'bodyMedium': baseFontSize / scaleRatio,
      'bodySmall': baseFontSize / (scaleRatio * scaleRatio),
      'labelLarge': baseFontSize / scaleRatio,
      'labelMedium': baseFontSize / (scaleRatio * scaleRatio),
      'labelSmall': baseFontSize / (scaleRatio * scaleRatio),
    };
  }

  // ==================== LAYOUT UTILITIES ====================

  /// Calculate responsive padding based on screen size
  static EdgeInsets calculateResponsivePadding({
    required double screenWidth,
    required double basePadding,
    double minPadding = 8.0,
    double maxPadding = 32.0,
  }) {
    var calculatedPadding = basePadding;

    if (screenWidth < 360) {
      calculatedPadding = basePadding * 0.75;
    } else if (screenWidth > 768) {
      calculatedPadding = basePadding * 1.25;
    }

    final clampedPadding = calculatedPadding.clamp(minPadding, maxPadding);
    return EdgeInsets.all(clampedPadding);
  }

  /// Generate consistent border radius values
  static Map<String, BorderRadius> generateBorderRadiusScale({
    required double baseRadius,
    double scaleRatio = 1.5,
  }) {
    return {
      'none': BorderRadius.zero,
      'small': BorderRadius.circular(baseRadius / scaleRatio),
      'medium': BorderRadius.circular(baseRadius),
      'large': BorderRadius.circular(baseRadius * scaleRatio),
      'extraLarge': BorderRadius.circular(baseRadius * scaleRatio * scaleRatio),
      'circular': BorderRadius.circular(999),
    };
  }

  // ==================== SHADOW UTILITIES ====================

  /// Create elevation-based shadow
  static List<BoxShadow> createElevationShadow({
    required double elevation,
    Color shadowColor = Colors.black,
    double opacity = 0.2,
  }) {
    if (elevation <= 0) return [];

    return [
      BoxShadow(
        color: shadowColor.withValues(alpha: opacity),
        blurRadius: elevation * 2,
        offset: Offset(0, elevation),
        spreadRadius: elevation * 0.5,
      ),
    ];
  }

  /// Create neumorphism shadow effect
  static List<BoxShadow> createNeumorphismShadow({
    required Color lightShadow,
    required Color darkShadow,
    double blurRadius = 8.0,
    double offset = 4.0,
  }) {
    return [
      BoxShadow(
        color: darkShadow,
        offset: Offset(offset, offset),
        blurRadius: blurRadius,
      ),
      BoxShadow(
        color: lightShadow,
        offset: Offset(-offset, -offset),
        blurRadius: blurRadius,
      ),
    ];
  }

  /// Create neon glow effect
  static List<BoxShadow> createNeonGlow({
    required Color glowColor,
    double intensity = 1.0,
  }) {
    return [
      BoxShadow(
        color: glowColor.withValues(alpha: 0.6 * intensity),
        blurRadius: 4 * intensity,
        spreadRadius: 1 * intensity,
      ),
      BoxShadow(
        color: glowColor.withValues(alpha: 0.3 * intensity),
        blurRadius: 8 * intensity,
        spreadRadius: 2 * intensity,
      ),
      BoxShadow(
        color: glowColor.withValues(alpha: 0.1 * intensity),
        blurRadius: 16 * intensity,
        spreadRadius: 4 * intensity,
      ),
    ];
  }

  // ==================== ANIMATION UTILITIES ====================

  /// Create consistent animation curve based on theme
  static Curve getAnimationCurve(String themeType) {
    switch (themeType.toLowerCase()) {
      case 'cyberpunk':
        return Curves.easeInOutCubic;
      case 'glassmorphism':
        return Curves.easeInOutQuart;
      case 'neumorphism':
        return Curves.easeInOutBack;
      default:
        return Curves.easeInOut;
    }
  }

  /// Get animation duration based on interaction type
  static Duration getAnimationDuration(String interactionType) {
    switch (interactionType.toLowerCase()) {
      case 'tap':
      case 'button':
        return ThemeConstants.fastAnimation;
      case 'page':
      case 'navigation':
        return ThemeConstants.normalAnimation;
      case 'modal':
      case 'dialog':
        return ThemeConstants.slowAnimation;
      default:
        return ThemeConstants.normalAnimation;
    }
  }

  // ==================== VALIDATION UTILITIES ====================

  /// Validate theme configuration
  static List<String> validateThemeConfiguration(ThemeConfiguration config) {
    final errors = <String>[];

    // Validate theme ID
    if (config.themeId.isEmpty ||
        config.themeId.length > ThemeConstants.maxThemeIdLength) {
      errors.add(
        'Theme ID must be between 1 and '
        '${ThemeConstants.maxThemeIdLength} characters',
      );
    }

    // Validate theme name
    if (config.themeName.isEmpty ||
        config.themeName.length > ThemeConstants.maxThemeNameLength) {
      errors.add(
        'Theme name must be between 1 and '
        '${ThemeConstants.maxThemeNameLength} characters',
      );
    }

    // Validate theme description
    if (config.themeDescription.length >
        ThemeConstants.maxThemeDescriptionLength) {
      errors.add(
        'Theme description must not exceed '
        '${ThemeConstants.maxThemeDescriptionLength} characters',
      );
    }

    // Validate color accessibility
    if (!isAccessible(config.primaryTextColor, config.backgroundColor)) {
      errors.add(
        'Primary text color does not meet accessibility '
        'contrast requirements',
      );
    }

    if (!isAccessible(config.secondaryTextColor, config.backgroundColor)) {
      errors.add(
        'Secondary text color does not meet accessibility '
        'contrast requirements',
      );
    }

    return errors;
  }

  /// Performance validation for theme creation
  static bool validateThemePerformance(Duration creationTime) {
    return creationTime.inMilliseconds <= ThemeConstants.maxThemeCreationTime;
  }
}
