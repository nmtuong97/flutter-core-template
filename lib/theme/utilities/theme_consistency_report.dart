import 'dart:io';
import 'package:flutter/foundation.dart';

/// Simple theme consistency checker không cần Flutter dependencies
class ThemeConsistencyChecker {
  static Future<void> generateReport() async {
    final themesDir = Directory('lib/theme/themes');

    if (!themesDir.existsSync()) {
      debugPrint('❌ Themes directory không tồn tại');
      return;
    }

    final themeFiles = themesDir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('_theme.dart'))
        .toList();

    debugPrint('🔍 Theme Consistency Report');
    debugPrint('=' * 50);
    debugPrint('Total theme files: ${themeFiles.length}');
    debugPrint('');

    var standardizedCount = 0;
    var issuesCount = 0;

    for (final file in themeFiles) {
      final fileName = file.path.split('/').last;
      final content = await file.readAsString();

      debugPrint('📄 Analyzing: $fileName');

      // Check standardization
      final hasStandardImport = content.contains('theme_standardization.dart');
      final usesStandardTextStyle =
          content.contains('ThemeStandardization.standardTextStyle');
      final usesStandardTextTheme =
          content.contains('ThemeStandardization.standardTextTheme');

      if (hasStandardImport && usesStandardTextStyle && usesStandardTextTheme) {
        debugPrint('  ✅ Fully standardized');
        standardizedCount++;
      } else {
        debugPrint('  ⚠️  Needs standardization:');
        if (!hasStandardImport) {
          debugPrint('    - Missing theme_standardization.dart import');
          issuesCount++;
        }
        if (!usesStandardTextStyle) {
          debugPrint('    - Not using ThemeStandardization.standardTextStyle');
          issuesCount++;
        }
        if (!usesStandardTextTheme) {
          debugPrint('    - Not using ThemeStandardization.standardTextTheme');
          issuesCount++;
        }
      }

      // Check method signatures
      final hasStandardTextStyleSignature =
          content.contains('bool hasShadow = false') &&
              content.contains('Color? shadowColor') &&
              content.contains('double? letterSpacing');

      final hasStandardTextThemeSignature =
          content.contains('required double baseFontSize') &&
              content.contains('Color? accentColor') &&
              content.contains('bool hasTextShadow = false');

      if (!hasStandardTextStyleSignature) {
        debugPrint('    - _getTextStyle signature needs updating');
        issuesCount++;
      }

      if (!hasStandardTextThemeSignature) {
        debugPrint('    - _getTextTheme signature needs updating');
        issuesCount++;
      }

      debugPrint('');
    }

    // Summary
    debugPrint('📊 Summary');
    debugPrint('=' * 30);
    debugPrint('Fully standardized themes: '
        '$standardizedCount/${themeFiles.length}');
    debugPrint('Total issues found: $issuesCount');

    final consistencyScore =
        ((standardizedCount / themeFiles.length) * 100).round();
    debugPrint('Consistency score: $consistencyScore%');

    if (consistencyScore >= 80) {
      debugPrint('🎉 Good consistency!');
    } else {
      debugPrint('⚠️  Needs improvement');
    }

    // Migration suggestions
    debugPrint('');
    debugPrint('💡 Next Steps:');
    if (issuesCount > 0) {
      debugPrint('1. Add theme_standardization.dart imports to all themes');
      debugPrint('2. Update method signatures to use standard parameters');
      debugPrint('3. Replace legacy method calls with '
          'ThemeStandardization utilities');
      debugPrint('4. Test all themes after migration');
    } else {
      debugPrint('✅ All themes are consistent! '
          'Consider running performance optimization.');
    }
  }
}

void main() async {
  await ThemeConsistencyChecker.generateReport();
}
