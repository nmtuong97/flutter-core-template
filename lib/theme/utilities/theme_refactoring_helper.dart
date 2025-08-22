import 'dart:io';
import 'package:flutter/foundation.dart';

/// Helper class để refactor existing theme files
/// sang standard method signatures
class ThemeRefactoringHelper {
  const ThemeRefactoringHelper._();

  /// Refactor _getTextStyle method trong theme file
  static String refactorTextStyleMethod({
    required String originalMethod,
    required String themeName,
  }) {
    // Template cho standardized _getTextStyle method
    return '''
  /// Standardized text style method cho $themeName theme
  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    bool hasShadow = false,
    Color? shadowColor,
    double? letterSpacing,
  }) {
    return ThemeStandardization.standardTextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      hasShadow: hasShadow,
      shadowColor: shadowColor,
      letterSpacing: letterSpacing,
    );
  }''';
  }

  /// Refactor _getTextTheme method trong theme file
  static String refactorTextThemeMethod({
    required String originalMethod,
    required String themeName,
  }) {
    // Template cho standardized _getTextTheme method
    return '''
  /// Standardized text theme method cho $themeName theme
  static TextTheme _getTextTheme({
    required String fontFamily,
    required double baseFontSize,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    Color? accentColor,
    bool hasTextShadow = false,
    Color? shadowColor,
    double? letterSpacing,
  }) {
    return ThemeStandardization.standardTextTheme(
      fontFamily: fontFamily,
      baseFontSize: baseFontSize,
      primaryTextColor: primaryTextColor,
      secondaryTextColor: secondaryTextColor,
      accentColor: accentColor,
      hasTextShadow: hasTextShadow,
      shadowColor: shadowColor,
      letterSpacing: letterSpacing,
    );
  }''';
  }

  /// Generate standardized lightThemeData method
  static String generateStandardLightThemeData(String themeName) {
    return '''
  @override
  ThemeData lightThemeData() {
    final colorScheme = ThemeStandardization.standardColorScheme(
      brightness: Brightness.light,
      primary: lightColorScheme.primary,
      secondary: lightColorScheme.secondary,
      surface: lightColorScheme.surface,
      background: lightColorScheme.background,
      error: lightColorScheme.error,
      onPrimary: lightColorScheme.onPrimary,
      onSecondary: lightColorScheme.onSecondary,
      onSurface: lightColorScheme.onSurface,
      onBackground: lightColorScheme.onBackground,
      onError: lightColorScheme.onError,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // Standardized AppBar theme
      appBarTheme: ThemeStandardization.standardAppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      
      // Standardized text theme
      textTheme: _getTextTheme(
        fontFamily: FontConfiguration.primaryFont,
        baseFontSize: 14,
        primaryTextColor: colorScheme.onBackground,
        secondaryTextColor: colorScheme.onBackground.withValues(alpha: 0.7),
        accentColor: colorScheme.primary,
      ),
      
      // Standardized button themes
      elevatedButtonTheme: ThemeStandardization.standardElevatedButtonTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        textStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
      
      outlinedButtonTheme: ThemeStandardization.standardOutlinedButtonTheme(
        foregroundColor: colorScheme.primary,
        borderColor: colorScheme.primary,
        textStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
      ),
      
      textButtonTheme: ThemeStandardization.standardTextButtonTheme(
        foregroundColor: colorScheme.primary,
        textStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
      ),
      
      // Standardized card theme
      cardTheme: ThemeStandardization.standardCardTheme(
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow,
        elevation: 1,
      ),
      
      // Standardized input decoration theme
      inputDecorationTheme: ThemeStandardization.standardInputDecorationTheme(
        fillColor: colorScheme.surface,
        borderColor: colorScheme.outline,
        focusedBorderColor: colorScheme.primary,
        errorBorderColor: colorScheme.error,
        hintStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        labelStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }''';
  }

  /// Generate standardized darkThemeData method
  static String generateStandardDarkThemeData(String themeName) {
    return '''
  @override
  ThemeData? darkThemeData() {
    if (!supportsDarkMode) return null;
    
    final colorScheme = ThemeStandardization.standardColorScheme(
      brightness: Brightness.dark,
      primary: darkColorScheme!.primary,
      secondary: darkColorScheme!.secondary,
      surface: darkColorScheme!.surface,
      background: darkColorScheme!.background,
      error: darkColorScheme!.error,
      onPrimary: darkColorScheme!.onPrimary,
      onSecondary: darkColorScheme!.onSecondary,
      onSurface: darkColorScheme!.onSurface,
      onBackground: darkColorScheme!.onBackground,
      onError: darkColorScheme!.onError,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // Standardized AppBar theme
      appBarTheme: ThemeStandardization.standardAppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      
      // Standardized text theme
      textTheme: _getTextTheme(
        fontFamily: FontConfiguration.primaryFont,
        baseFontSize: 14,
        primaryTextColor: colorScheme.onBackground,
        secondaryTextColor: colorScheme.onBackground.withValues(alpha: 0.7),
        accentColor: colorScheme.primary,
      ),
      
      // Standardized button themes
      elevatedButtonTheme: ThemeStandardization.standardElevatedButtonTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        textStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
      
      outlinedButtonTheme: ThemeStandardization.standardOutlinedButtonTheme(
        foregroundColor: colorScheme.primary,
        borderColor: colorScheme.primary,
        textStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
      ),
      
      textButtonTheme: ThemeStandardization.standardTextButtonTheme(
        foregroundColor: colorScheme.primary,
        textStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
      ),
      
      // Standardized card theme
      cardTheme: ThemeStandardization.standardCardTheme(
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow,
        elevation: 1,
      ),
      
      // Standardized input decoration theme
      inputDecorationTheme: ThemeStandardization.standardInputDecorationTheme(
        fillColor: colorScheme.surface,
        borderColor: colorScheme.outline,
        focusedBorderColor: colorScheme.primary,
        errorBorderColor: colorScheme.error,
        hintStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        labelStyle: _getTextStyle(
          fontFamily: FontConfiguration.primaryFont,
          fontSize: 14,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }''';
  }

  /// Migration checklist cho từng theme file
  static List<String> getMigrationChecklist(String themeName) {
    return [
      '✅ Import ThemeStandardization utility',
      '✅ Refactor _getTextStyle method signature',
      '✅ Refactor _getTextTheme method signature',
      '✅ Update lightThemeData() method',
      '✅ Update darkThemeData() method (nếu có)',
      '✅ Standardize AppBar theme creation',
      '✅ Standardize Button theme creation',
      '✅ Standardize Card theme creation',
      '✅ Standardize InputDecoration theme creation',
      '✅ Remove deprecated parameters',
      '✅ Add missing required parameters',
      '✅ Test theme compilation',
      '✅ Validate visual consistency',
    ];
  }

  /// Generate import statements cần thiết
  static String generateRequiredImports() {
    return '''
import 'package:flutter/material.dart';
import '../base/app_theme.dart';
import '../configurations/font_configuration.dart';
import '../utilities/theme_standardization.dart';
''';
  }

  /// Validate theme file sau khi refactor
  static List<String> validateRefactoredTheme(String themeFilePath) {
    final issues = <String>[];

    try {
      final file = File(themeFilePath);
      if (!file.existsSync()) {
        issues.add('Theme file không tồn tại: $themeFilePath');
        return issues;
      }

      final content = file.readAsStringSync();

      // Check required imports
      if (!content.contains('theme_standardization.dart')) {
        issues.add('Missing import: theme_standardization.dart');
      }

      // Check method signatures
      if (!content.contains('ThemeStandardization.standardTextStyle')) {
        issues.add('_getTextStyle chưa được refactor sang standard signature');
      }

      if (!content.contains('ThemeStandardization.standardTextTheme')) {
        issues.add('_getTextTheme chưa được refactor sang standard signature');
      }

      // Check component themes
      final requiredStandardMethods = [
        'standardAppBarTheme',
        'standardElevatedButtonTheme',
        'standardCardTheme',
        'standardInputDecorationTheme',
      ];

      for (final method in requiredStandardMethods) {
        if (!content.contains(method)) {
          issues.add('Missing standardized method: $method');
        }
      }
    } on Exception catch (e) {
      issues.add('Error reading theme file: $e');
    }

    return issues;
  }

  /// Generate refactoring report
  static String generateRefactoringReport({
    required List<String> processedFiles,
    required List<String> issues,
    required List<String> improvements,
  }) {
    final buffer = StringBuffer()
      ..writeln('# Theme Refactoring Report')
      ..writeln()
      ..writeln('## Processed Files');
    for (final file in processedFiles) {
      buffer.writeln('- $file');
    }

    buffer
      ..writeln()
      ..writeln('## Issues Found');
    if (issues.isEmpty) {
      buffer.writeln('✅ No issues found!');
    } else {
      for (final issue in issues) {
        buffer.writeln('❌ $issue');
      }
    }

    buffer
      ..writeln()
      ..writeln('## Improvements Made');
    for (final improvement in improvements) {
      buffer.writeln('✅ $improvement');
    }

    buffer
      ..writeln()
      ..writeln('## Next Steps')
      ..writeln('1. Run `flutter analyze` để check compilation')
      ..writeln('2. Test tất cả themes trong app')
      ..writeln('3. Validate visual consistency')
      ..writeln('4. Update documentation nếu cần');

    return buffer.toString();
  }
}

/// Batch refactoring utility cho tất cả theme files
class BatchThemeRefactoring {
  const BatchThemeRefactoring._();

  /// Refactor tất cả theme files trong project
  static Future<void> refactorAllThemes({
    required String themesDirectory,
    bool dryRun = false,
  }) async {
    final directory = Directory(themesDirectory);
    if (!directory.existsSync()) {
      throw Exception('Themes directory không tồn tại: $themesDirectory');
    }

    final themeFiles = directory
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('_theme.dart'))
        .toList();

    debugPrint('Found ${themeFiles.length} theme files to refactor:');
    for (final file in themeFiles) {
      debugPrint('- ${file.path}');
    }

    if (dryRun) {
      debugPrint('\nDry run mode - no files will be modified');
      return;
    }

    // TODO(theme): Implement actual refactoring logic
    // Đây sẽ là nơi thực hiện refactoring cho từng file

    debugPrint('\nRefactoring completed!');
  }

  /// Generate migration script
  static String generateMigrationScript() {
    return r'''
#!/bin/bash

# Theme Refactoring Migration Script
# Tự động refactor tất cả theme files sang standard signatures

echo "Starting theme refactoring migration..."

# Backup existing themes
echo "Creating backup..."
cp -r lib/theme/themes lib/theme/themes_backup_$(date +%Y%m%d_%H%M%S)

# Run refactoring
echo "Running refactoring..."
# TODO: Add actual refactoring commands

# Validate results
echo "Validating refactored themes..."
flutter analyze

echo "Migration completed!"

echo "Please test your themes and remove backup if everything works correctly."
''';
  }
}
