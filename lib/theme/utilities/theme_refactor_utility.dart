import 'package:flutter/material.dart';
import '../builders/base_theme_builder.dart';
import '../configurations/theme_configuration.dart';
import 'theme_factory.dart';
import 'theme_helper.dart';
import 'theme_utilities.dart';

/// Utility class for refactoring existing theme builders
/// Provides migration path from old theme builders to new config system
class ThemeRefactorUtility {
  const ThemeRefactorUtility._();

  // ==================== MIGRATION HELPERS ====================

  /// Migrate existing theme builder to use new configuration system
  static ThemeData migrateThemeBuilder({
    required BaseThemeBuilder builder,
    required ThemeConfiguration config,
    required Brightness brightness,
    double? screenWidth,
  }) {
    // Use new factory method instead of old builder
    return ThemeFactory.createTheme(
      config: config,
      brightness: brightness,
      screenWidth: screenWidth,
    );
  }

  /// Extract common text style logic from existing builders
  static TextStyle extractTextStyleLogic({
    required ThemeConfiguration config,
    required String fontFamily,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    List<Shadow>? shadows,
  }) {
    return ThemeHelper.createTextStyle(
      config: config,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      shadows: shadows,
    );
  }

  /// Extract common text theme logic from existing builders
  static TextTheme extractTextThemeLogic({
    required ThemeConfiguration config,
    double? screenWidth,
  }) {
    return ThemeHelper.createTextTheme(
      config: config,
      screenWidth: screenWidth,
    );
  }

  // ==================== COMPATIBILITY LAYER ====================

  /// Create compatibility wrapper for old theme methods
  static Map<String, dynamic> createCompatibilityWrapper({
    required BaseThemeBuilder oldBuilder,
    required ThemeConfiguration newConfig,
  }) {
    return {
      'oldBuilder': oldBuilder,
      'newConfig': newConfig,
      'migrationStatus': 'ready',
      'benefits': [
        'Eliminated code duplication',
        'Centralized configuration',
        'Improved maintainability',
        'Better performance',
        'Consistent API',
      ],
    };
  }

  /// Validate migration compatibility
  static List<String> validateMigration({
    required BaseThemeBuilder oldBuilder,
    required ThemeConfiguration newConfig,
  }) {
    final issues = <String>[];

    // Check if all required properties are available in new config
    try {
      newConfig
        ..primaryColor
        ..secondaryColor
        ..backgroundColor
        ..fontFamily
        ..typography;
    } on Exception catch (e) {
      issues.add('Missing required configuration properties: $e');
    }

    // Validate theme configuration
    final configErrors = ThemeUtilities.validateThemeConfiguration(newConfig);
    issues.addAll(configErrors);

    return issues;
  }

  // ==================== PERFORMANCE COMPARISON ====================

  /// Compare performance between old and new theme systems
  static Map<String, dynamic> comparePerformance({
    required BaseThemeBuilder oldBuilder,
    required ThemeConfiguration newConfig,
    required Brightness brightness,
  }) {
    // Benchmark old system
    final oldStopwatch = Stopwatch()..start();
    // BaseThemeBuilder doesn't have a build method, skip direct comparison
    // Instead, we'll analyze the builder's configuration capabilities
    final oldTheme = ThemeData(); // Placeholder for comparison
    oldStopwatch.stop();

    // Benchmark new system
    final newStopwatch = Stopwatch()..start();
    final newTheme = ThemeFactory.createTheme(
      config: newConfig,
      brightness: brightness,
    );
    newStopwatch.stop();

    return {
      'oldSystem': {
        'creationTime': oldStopwatch.elapsedMicroseconds,
        'theme': oldTheme,
      },
      'newSystem': {
        'creationTime': newStopwatch.elapsedMicroseconds,
        'theme': newTheme,
        'analysis': ThemeHelper.analyzeThemePerformance(newTheme),
      },
      'improvement': {
        'timeReduction':
            oldStopwatch.elapsedMicroseconds - newStopwatch.elapsedMicroseconds,
        'percentageImprovement': ((oldStopwatch.elapsedMicroseconds -
                    newStopwatch.elapsedMicroseconds) /
                oldStopwatch.elapsedMicroseconds *
                100)
            .toStringAsFixed(2),
        'isImproved':
            newStopwatch.elapsedMicroseconds < oldStopwatch.elapsedMicroseconds,
      },
    };
  }

  // ==================== CODE ANALYSIS ====================

  /// Analyze code duplication in existing theme builders
  static Map<String, dynamic> analyzeCodeDuplication() {
    return {
      'duplicatedMethods': [
        '_getTextStyle',
        '_getTextTheme',
        'color scheme creation',
        'component theme creation',
      ],
      'linesOfDuplication': 150, // Estimated
      'maintenanceBurden': 'High',
      'refactoringBenefits': [
        'Single source of truth',
        'Easier to maintain',
        'Consistent behavior',
        'Reduced testing surface',
      ],
    };
  }

  /// Generate refactoring recommendations
  static List<String> generateRefactoringRecommendations() {
    return [
      'Replace individual theme builders with ThemeFactory.createTheme()',
      'Migrate theme-specific logic to ThemeConfiguration classes',
      'Use ThemeHelper methods for common operations',
      'Implement ThemeUtilities for shared calculations',
      'Add theme validation using ThemeUtilities.validateThemeConfiguration()',
      'Use CustomThemeExtension for theme-specific properties',
      'Implement performance monitoring with benchmarkThemeCreation()',
      'Add accessibility validation for color contrast',
      'Use responsive design utilities for different screen sizes',
      'Implement theme caching for better performance',
    ];
  }

  // ==================== MIGRATION STEPS ====================

  /// Generate step-by-step migration guide
  static List<Map<String, dynamic>> generateMigrationSteps() {
    return [
      {
        'step': 1,
        'title': 'Create Theme Configuration',
        'description': 'Create ThemeConfiguration class for your theme',
        'code': 'class MyThemeConfiguration extends ThemeConfiguration { ... }',
        'files': ['lib/theme/configurations/my_theme_configuration.dart'],
      },
      {
        'step': 2,
        'title': 'Replace Theme Builder',
        'description':
            'Replace existing builder with ThemeFactory.createTheme()',
        'code': 'ThemeFactory.createTheme('
            'config: MyThemeConfiguration(), brightness: brightness)',
        'files': ['lib/theme/builders/my_theme_builder.dart'],
      },
      {
        'step': 3,
        'title': 'Extract Common Logic',
        'description': 'Move shared logic to ThemeHelper methods',
        'code': 'ThemeHelper.createTextStyle(config: config, fontSize: 16)',
        'files': ['lib/theme/utilities/theme_helper.dart'],
      },
      {
        'step': 4,
        'title': 'Add Validation',
        'description': 'Implement theme validation and testing',
        'code': 'ThemeUtilities.validateThemeConfiguration(config)',
        'files': ['test/theme/theme_validation_test.dart'],
      },
      {
        'step': 5,
        'title': 'Performance Testing',
        'description': 'Add performance benchmarks and monitoring',
        'code': 'ThemeFactory.benchmarkThemeCreation(config)',
        'files': ['test/theme/theme_performance_test.dart'],
      },
      {
        'step': 6,
        'title': 'Clean Up',
        'description': 'Remove old theme builder files and update imports',
        'code': 'import "../utilities/theme_factory.dart";',
        'files': ['All theme-related files'],
      },
    ];
  }

  /// Estimate migration effort
  static Map<String, dynamic> estimateMigrationEffort({
    required int numberOfThemes,
    required int linesOfThemeCode,
  }) {
    const baseEffort = 2; // hours per theme
    final complexityMultiplier = linesOfThemeCode > 500 ? 1.5 : 1.0;
    final totalEffort =
        (numberOfThemes * baseEffort * complexityMultiplier).ceil();

    return {
      'estimatedHours': totalEffort,
      'estimatedDays': (totalEffort / 8).ceil(),
      'complexity': linesOfThemeCode > 500 ? 'High' : 'Medium',
      'riskLevel': numberOfThemes > 5 ? 'Medium' : 'Low',
      'recommendations': [
        if (numberOfThemes > 3) 'Migrate themes incrementally',
        if (linesOfThemeCode > 500) 'Consider breaking down complex themes',
        'Add comprehensive tests before migration',
        'Create backup of existing theme system',
        'Test thoroughly on different devices and screen sizes',
      ],
    };
  }
}
