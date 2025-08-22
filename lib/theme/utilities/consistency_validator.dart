import 'dart:io';
import 'package:flutter/foundation.dart';

/// Utility để validate consistency across theme files
/// và generate reports về standardization progress
class ConsistencyValidator {
  const ConsistencyValidator._();

  /// Validate tất cả theme files trong project
  static Future<ConsistencyReport> validateAllThemes({
    required String themesDirectory,
  }) async {
    final report = ConsistencyReport();

    try {
      final directory = Directory(themesDirectory);
      if (!directory.existsSync()) {
        report.addError('Themes directory không tồn tại: $themesDirectory');
        return report;
      }

      final themeFiles = directory
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('_theme.dart'))
          .toList();

      report.totalFiles = themeFiles.length;

      for (final file in themeFiles) {
        final fileName = file.path.split('/').last;
        report.processedFiles.add(fileName);

        await _validateSingleTheme(file, report);
      }
    } on Exception catch (e) {
      report.addError('Error during validation: $e');
    }

    return report;
  }

  /// Validate một theme file cụ thể
  static Future<void> _validateSingleTheme(
    File themeFile,
    ConsistencyReport report,
  ) async {
    try {
      final content = await themeFile.readAsString();
      final fileName = themeFile.path.split('/').last;

      // Check imports
      _validateImports(content, fileName, report);

      // Check method signatures
      _validateMethodSignatures(content, fileName, report);

      // Check standardization usage
      _validateStandardizationUsage(content, fileName, report);

      // Check component themes
      _validateComponentThemes(content, fileName, report);
    } on Exception catch (e) {
      report.addError('Error validating $themeFile: $e');
    }
  }

  /// Validate required imports
  static void _validateImports(
    String content,
    String fileName,
    ConsistencyReport report,
  ) {
    final requiredImports = [
      'theme_standardization.dart',
      'font_configuration.dart',
      'app_theme.dart',
    ];

    for (final import in requiredImports) {
      if (!content.contains(import)) {
        report.addIssue(
          fileName,
          'Missing required import: $import',
          IssueType.missingImport,
        );
      }
    }

    // Check for deprecated imports
    final deprecatedImports = [
      'theme_typography.dart', // Should use standardization instead
    ];

    for (final import in deprecatedImports) {
      if (content.contains(import)) {
        report.addIssue(
          fileName,
          'Using deprecated import: $import',
          IssueType.deprecatedImport,
        );
      }
    }
  }

  /// Validate method signatures consistency
  static void _validateMethodSignatures(
    String content,
    String fileName,
    ConsistencyReport report,
  ) {
    // Check _getTextStyle signature
    if (content.contains('static TextStyle _getTextStyle(')) {
      final requiredParams = [
        'required String fontFamily',
        'required double fontSize',
        'FontWeight fontWeight',
        'Color? color',
        'bool hasShadow',
        'Color? shadowColor',
        'double? letterSpacing',
      ];

      for (final param in requiredParams) {
        if (!content.contains(param)) {
          report.addIssue(
            fileName,
            '_getTextStyle missing parameter: $param',
            IssueType.inconsistentSignature,
          );
        }
      }
    }

    // Check _getTextTheme signature
    if (content.contains('TextTheme _getTextTheme(')) {
      final requiredParams = [
        'required String fontFamily',
        'required double baseFontSize',
        'required Color primaryTextColor',
        'required Color secondaryTextColor',
        'Color? accentColor',
        'bool hasTextShadow',
        'Color? shadowColor',
        'double? letterSpacing',
      ];

      for (final param in requiredParams) {
        if (!content.contains(param)) {
          report.addIssue(
            fileName,
            '_getTextTheme missing parameter: $param',
            IssueType.inconsistentSignature,
          );
        }
      }
    }
  }

  /// Validate usage of ThemeStandardization
  static void _validateStandardizationUsage(
    String content,
    String fileName,
    ConsistencyReport report,
  ) {
    // Check if using standardized methods
    final standardMethods = [
      'ThemeStandardization.standardTextStyle',
      'ThemeStandardization.standardTextTheme',
      'ThemeStandardization.standardColorScheme',
      'ThemeStandardization.standardAppBarTheme',
      'ThemeStandardization.standardElevatedButtonTheme',
    ];

    var usingStandardization = false;
    for (final method in standardMethods) {
      if (content.contains(method)) {
        usingStandardization = true;
        report.addImprovement(
          fileName,
          'Using standardized method: $method',
        );
      }
    }

    if (!usingStandardization) {
      report.addIssue(
        fileName,
        'Not using ThemeStandardization utilities',
        IssueType.notStandardized,
      );
    }

    // Check for legacy method usage
    final legacyMethods = [
      '_typography.getTextStyle',
      'TextStyle(',
      'TextTheme(',
    ];

    for (final method in legacyMethods) {
      if (content.contains(method) &&
          !content.contains('ThemeStandardization')) {
        report.addIssue(
          fileName,
          'Using legacy method instead of standardized: $method',
          IssueType.legacyUsage,
        );
      }
    }
  }

  /// Validate component theme consistency
  static void _validateComponentThemes(
    String content,
    String fileName,
    ConsistencyReport report,
  ) {
    final componentThemes = {
      'appBarTheme': 'AppBarTheme',
      'elevatedButtonTheme': 'ElevatedButtonThemeData',
      'outlinedButtonTheme': 'OutlinedButtonThemeData',
      'textButtonTheme': 'TextButtonThemeData',
      'cardTheme': 'CardThemeData',
      'inputDecorationTheme': 'InputDecorationTheme',
    };

    for (final entry in componentThemes.entries) {
      final themeProperty = entry.key;
      final themeType = entry.value;

      if (content.contains('$themeProperty:')) {
        // Check if using standardized creation
        final standardMethod = 'ThemeStandardization.standard'
            '${themeType.replaceAll('Data', '').replaceAll('Theme', '')}'
            'Theme';

        if (!content.contains(standardMethod)) {
          report.addIssue(
            fileName,
            '$themeProperty not using standardized creation method',
            IssueType.componentNotStandardized,
          );
        }
      }
    }
  }

  /// Generate migration suggestions
  static List<String> generateMigrationSuggestions(
    ConsistencyReport report,
  ) {
    final suggestions = <String>[];

    // Group issues by type
    final issuesByType = <IssueType, List<ConsistencyIssue>>{};
    for (final issue in report.issues) {
      issuesByType.putIfAbsent(issue.type, () => []).add(issue);
    }

    // Generate suggestions based on issue types
    if (issuesByType.containsKey(IssueType.missingImport)) {
      suggestions.add('Add missing imports: theme_standardization.dart');
    }

    if (issuesByType.containsKey(IssueType.inconsistentSignature)) {
      suggestions.add('Standardize method signatures across all themes');
    }

    if (issuesByType.containsKey(IssueType.notStandardized)) {
      suggestions.add('Migrate to ThemeStandardization utilities');
    }

    if (issuesByType.containsKey(IssueType.legacyUsage)) {
      suggestions.add('Replace legacy methods with standardized equivalents');
    }

    if (issuesByType.containsKey(IssueType.componentNotStandardized)) {
      suggestions.add('Use standardized component theme creation methods');
    }

    return suggestions;
  }
}

/// Report class để track validation results
class ConsistencyReport {
  int totalFiles = 0;
  final List<String> processedFiles = [];
  final List<ConsistencyIssue> issues = [];
  final List<String> improvements = [];
  final List<String> errors = [];

  void addIssue(String fileName, String description, IssueType type) {
    issues.add(
      ConsistencyIssue(
        fileName: fileName,
        description: description,
        type: type,
      ),
    );
  }

  void addImprovement(String fileName, String description) {
    improvements.add('$fileName: $description');
  }

  void addError(String error) {
    errors.add(error);
  }

  /// Generate summary report
  String generateSummary() {
    final buffer = StringBuffer()
      ..writeln('# Theme Consistency Validation Report')
      ..writeln()
      ..writeln('## Summary')
      ..writeln('- Total files processed: $totalFiles')
      ..writeln('- Issues found: ${issues.length}')
      ..writeln('- Improvements detected: ${improvements.length}')
      ..writeln('- Errors: ${errors.length}');

    if (errors.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('## Errors');
      for (final error in errors) {
        buffer.writeln('❌ $error');
      }
    }

    if (issues.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('## Issues by Type');

      final issuesByType = <IssueType, List<ConsistencyIssue>>{};
      for (final issue in issues) {
        issuesByType.putIfAbsent(issue.type, () => []).add(issue);
      }

      for (final entry in issuesByType.entries) {
        buffer
          ..writeln()
          ..writeln('### ${entry.key.name.toUpperCase()}');
        for (final issue in entry.value) {
          buffer.writeln('- ${issue.fileName}: ${issue.description}');
        }
      }
    }

    if (improvements.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('## Improvements Detected');
      for (final improvement in improvements) {
        buffer.writeln('✅ $improvement');
      }
    }

    // Generate migration suggestions
    final suggestions = ConsistencyValidator.generateMigrationSuggestions(this);
    if (suggestions.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('## Migration Suggestions');
      for (final suggestion in suggestions) {
        buffer.writeln('💡 $suggestion');
      }
    }

    return buffer.toString();
  }

  /// Calculate consistency score (0-100)
  double get consistencyScore {
    if (totalFiles == 0) return 0;

    final totalPossibleIssues = totalFiles * 10; // Assume 10 checks per file
    final actualIssues = issues.length;

    return ((totalPossibleIssues - actualIssues) / totalPossibleIssues * 100)
        .clamp(0, 100);
  }
}

/// Individual consistency issue
class ConsistencyIssue {
  const ConsistencyIssue({
    required this.fileName,
    required this.description,
    required this.type,
  });
  final String fileName;
  final String description;
  final IssueType type;
}

/// Types of consistency issues
enum IssueType {
  missingImport,
  deprecatedImport,
  inconsistentSignature,
  notStandardized,
  legacyUsage,
  componentNotStandardized,
}

/// CLI utility để run validation
class ConsistencyValidatorCLI {
  static Future<void> main(List<String> args) async {
    final themesDir = args.isNotEmpty ? args[0] : 'lib/theme/themes';

    debugPrint('🔍 Validating theme consistency in: $themesDir');
    debugPrint('=' * 50);

    final report = await ConsistencyValidator.validateAllThemes(
      themesDirectory: themesDir,
    );

    debugPrint(report.generateSummary());

    debugPrint(
      '\n📊 Consistency Score: '
      '${report.consistencyScore.toStringAsFixed(1)}%',
    );

    if (report.consistencyScore < 80) {
      debugPrint('⚠️  Consistency score is below 80%. '
          'Consider running migration.');
    } else if (report.consistencyScore >= 95) {
      debugPrint('🎉 Excellent consistency! '
          'Themes are well standardized.');
    }
  }
}
