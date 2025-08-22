import 'package:flutter/material.dart';

import '../base/theme_interfaces.dart';
import '../constants/theme_constants.dart';

/// Validator để đảm bảo tính nhất quán và chất lượng của theme
class ThemeValidator {
  const ThemeValidator._();

  /// Validate một theme instance
  static ThemeValidationResult validateTheme(BaseTheme theme) {
    final errors = <String>[];
    final warnings = <String>[];

    // Validate basic properties
    _validateBasicProperties(theme, errors, warnings);

    // Validate theme data if available
    if (theme is LightThemeProvider) {
      final lightProvider = theme as LightThemeProvider;
      if (lightProvider.supportsLightMode) {
        try {
          final lightTheme = lightProvider.lightThemeData;
          _validateThemeData(lightTheme, 'Light', errors, warnings);
        } on Exception catch (e) {
          errors.add('Failed to create light theme data: $e');
        }
      }
    }

    if (theme is DarkThemeProvider) {
      final darkProvider = theme as DarkThemeProvider;
      if (darkProvider.supportsDarkMode) {
        try {
          final darkTheme = darkProvider.darkThemeData;
          _validateThemeData(darkTheme, 'Dark', errors, warnings);
        } on Exception catch (e) {
          errors.add('Failed to create dark theme data: $e');
        }
      }
    }

    return ThemeValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  /// Validate multiple themes for consistency
  static ThemeConsistencyResult validateThemeConsistency(
    List<BaseTheme> themes,
  ) {
    final errors = <String>[];
    final warnings = <String>[];

    if (themes.isEmpty) {
      errors.add('No themes provided for validation');
      return ThemeConsistencyResult(
        isConsistent: false,
        errors: errors,
        warnings: warnings,
      );
    }

    // Check for duplicate IDs
    _validateUniqueIds(themes, errors);

    // Check for default theme
    _validateDefaultTheme(themes, errors, warnings);

    // Validate theme capabilities consistency
    _validateCapabilities(themes, warnings);

    return ThemeConsistencyResult(
      isConsistent: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  /// Validate theme performance characteristics
  static ThemePerformanceResult validateThemePerformance(
    BaseTheme theme,
  ) {
    final warnings = <String>[];
    final suggestions = <String>[];

    // Check theme data creation time
    final stopwatch = Stopwatch()..start();

    if (theme is LightThemeProvider) {
      final lightProvider = theme as LightThemeProvider;
      if (lightProvider.supportsLightMode) {
        lightProvider.lightThemeData;
      }
    }
    if (theme is DarkThemeProvider) {
      final darkProvider = theme as DarkThemeProvider;
      if (darkProvider.supportsDarkMode) {
        darkProvider.darkThemeData;
      }
    }

    stopwatch.stop();
    final creationTime = stopwatch.elapsedMilliseconds;

    if (creationTime > ThemeConstants.maxThemeCreationTime) {
      warnings.add(
        'Theme creation took ${creationTime}ms, '
        'exceeds recommended ${ThemeConstants.maxThemeCreationTime}ms',
      );
      suggestions
          .add('Consider caching theme data or optimizing creation logic');
    }

    return ThemePerformanceResult(
      creationTimeMs: creationTime,
      isPerformant: warnings.isEmpty,
      warnings: warnings,
      suggestions: suggestions,
    );
  }

  static void _validateBasicProperties(
    BaseTheme theme,
    List<String> errors,
    List<String> warnings,
  ) {
    // Validate ID
    if (theme.id.isEmpty) {
      errors.add('Theme ID cannot be empty');
    } else if (theme.id.length > ThemeConstants.maxThemeIdLength) {
      errors.add(
        'Theme ID "${theme.id}" exceeds maximum length '
        'of ${ThemeConstants.maxThemeIdLength} characters',
      );
    } else if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(theme.id)) {
      errors.add(
        'Theme ID "${theme.id}" contains invalid characters. '
        'Only alphanumeric, underscore, and hyphen are allowed',
      );
    }

    // Validate name
    if (theme.name.isEmpty) {
      errors.add('Theme name cannot be empty');
    } else if (theme.name.length > ThemeConstants.maxThemeNameLength) {
      warnings.add(
        'Theme name "${theme.name}" is quite long '
        '(${theme.name.length} characters)',
      );
    }

    // Validate description
    if (theme.description.isEmpty) {
      warnings.add('Theme description is empty. Consider adding a description');
    } else if (theme.description.length >
        ThemeConstants.maxThemeDescriptionLength) {
      warnings.add(
        'Theme description is very long '
        '(${theme.description.length} characters)',
      );
    }
  }

  static void _validateThemeData(
    ThemeData themeData,
    String themeType,
    List<String> errors,
    List<String> warnings,
  ) {
    // Validate color scheme
    _validateColorScheme(themeData.colorScheme, themeType, warnings);

    // Validate Material 3 usage
    if (!themeData.useMaterial3) {
      warnings.add(
        '$themeType theme is not using Material 3. '
        'Consider upgrading for better design consistency',
      );
    }
  }

  static void _validateColorScheme(
    ColorScheme colorScheme,
    String themeType,
    List<String> warnings,
  ) {
    // Check contrast ratios (simplified validation)
    final primaryContrast = _calculateContrast(
      colorScheme.primary,
      colorScheme.onPrimary,
    );

    if (primaryContrast < ThemeConstants.minContrastRatio) {
      warnings.add(
        '$themeType theme primary/onPrimary contrast ratio '
        '($primaryContrast) is below recommended minimum '
        '(${ThemeConstants.minContrastRatio})',
      );
    }

    // Check secondary color contrast
    final secondaryContrast = _calculateContrast(
      colorScheme.secondary,
      colorScheme.onSecondary,
    );

    if (secondaryContrast < ThemeConstants.minContrastRatio) {
      warnings.add(
        '$themeType theme secondary/onSecondary contrast ratio '
        '($secondaryContrast) is below recommended minimum '
        '(${ThemeConstants.minContrastRatio})',
      );
    }

    // Check for similar colors that might cause confusion
    if (_colorsAreTooSimilar(colorScheme.primary, colorScheme.secondary)) {
      warnings.add(
        '$themeType theme primary and secondary colors are very similar. '
        'Consider using more distinct colors',
      );
    }
  }

  static void _validateUniqueIds(
    List<BaseTheme> themes,
    List<String> errors,
  ) {
    final seenIds = <String>{};
    for (final theme in themes) {
      if (seenIds.contains(theme.id)) {
        errors.add('Duplicate theme ID found: "${theme.id}"');
      } else {
        seenIds.add(theme.id);
      }
    }
  }

  static void _validateDefaultTheme(
    List<BaseTheme> themes,
    List<String> errors,
    List<String> warnings,
  ) {
    final defaultThemes = themes.where((theme) => theme.isDefault).toList();

    if (defaultThemes.isEmpty) {
      errors.add(
        'No default theme found. At least one theme must be marked as default',
      );
    } else if (defaultThemes.length > 1) {
      errors.add(
        'Multiple default themes found: '
        '${defaultThemes.map((t) => t.id).join(", ")}. '
        'Only one theme should be marked as default',
      );
    }
  }

  static void _validateCapabilities(
    List<BaseTheme> themes,
    List<String> warnings,
  ) {
    final lightSupportCount = themes
        .whereType<LightThemeProvider>()
        .where((theme) => theme.supportsLightMode)
        .length;

    final darkSupportCount = themes
        .whereType<DarkThemeProvider>()
        .where((theme) => theme.supportsDarkMode)
        .length;

    if (lightSupportCount == 0) {
      warnings.add('No themes support light mode');
    }

    if (darkSupportCount == 0) {
      warnings.add('No themes support dark mode');
    }
  }

  /// Calculate contrast ratio between two colors (simplified)
  static double _calculateContrast(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();

    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Check if two colors are too similar
  static bool _colorsAreTooSimilar(Color color1, Color color2) {
    final hsl1 = HSLColor.fromColor(color1);
    final hsl2 = HSLColor.fromColor(color2);

    final hueDiff = (hsl1.hue - hsl2.hue).abs();
    final satDiff = (hsl1.saturation - hsl2.saturation).abs();
    final lightDiff = (hsl1.lightness - hsl2.lightness).abs();

    // Colors are too similar if they're close in all dimensions
    return hueDiff < 30 && satDiff < 0.2 && lightDiff < 0.2;
  }
}

/// Result of theme validation
class ThemeValidationResult {
  const ThemeValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
  });

  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..writeln('Theme Validation Result:')
      ..writeln('Valid: $isValid');

    if (errors.isNotEmpty) {
      buffer.writeln('Errors:');
      for (final error in errors) {
        buffer.writeln('  - $error');
      }
    }

    if (warnings.isNotEmpty) {
      buffer.writeln('Warnings:');
      for (final warning in warnings) {
        buffer.writeln('  - $warning');
      }
    }

    return buffer.toString();
  }
}

/// Result of theme consistency validation
class ThemeConsistencyResult {
  const ThemeConsistencyResult({
    required this.isConsistent,
    required this.errors,
    required this.warnings,
  });

  final bool isConsistent;
  final List<String> errors;
  final List<String> warnings;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..writeln('Theme Consistency Result:')
      ..writeln('Consistent: $isConsistent');

    if (errors.isNotEmpty) {
      buffer.writeln('Errors:');
      for (final error in errors) {
        buffer.writeln('  - $error');
      }
    }

    if (warnings.isNotEmpty) {
      buffer.writeln('Warnings:');
      for (final warning in warnings) {
        buffer.writeln('  - $warning');
      }
    }

    return buffer.toString();
  }
}

/// Result of theme performance validation
class ThemePerformanceResult {
  const ThemePerformanceResult({
    required this.creationTimeMs,
    required this.isPerformant,
    required this.warnings,
    required this.suggestions,
  });

  final int creationTimeMs;
  final bool isPerformant;
  final List<String> warnings;
  final List<String> suggestions;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..writeln('Theme Performance Result:')
      ..writeln('Creation Time: ${creationTimeMs}ms')
      ..writeln('Performant: $isPerformant');

    if (warnings.isNotEmpty) {
      buffer.writeln('Warnings:');
      for (final warning in warnings) {
        buffer.writeln('  - $warning');
      }
    }

    if (suggestions.isNotEmpty) {
      buffer.writeln('Suggestions:');
      for (final suggestion in suggestions) {
        buffer.writeln('  - $suggestion');
      }
    }

    return buffer.toString();
  }
}
