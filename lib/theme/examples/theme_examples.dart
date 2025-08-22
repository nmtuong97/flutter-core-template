/// Theme examples and demonstrations for the theme system.
/// Examples demonstrating theme system usage.
/// Unused variables and print statements are intentionally used in examples
/// to demonstrate various theme configurations and testing patterns.
library;

// Ignoring unused_local_variable because these are example/demo variables
// Ignoring avoid_print because these are debugging examples showing theme usage
// ignore_for_file: unused_local_variable, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../base/theme_interfaces.dart';
import '../builders/theme_builder.dart';
import '../colors/color_palette.dart';
import '../constants/theme_constants.dart';
import '../theme_provider.dart';
import '../typography/font_configuration.dart';
import '../typography/theme_typography.dart';
import '../validators/theme_validator.dart';

/// Ví dụ về custom color palette
class ExampleColorPalette extends ColorPalette {
  @override
  ColorScheme toColorScheme(Brightness brightness) {
    return brightness == Brightness.light
        ? ColorScheme.light(
            primary: primary,
            onPrimary: onPrimary,
            secondary: secondary,
            onSecondary: onSecondary,
            surface: surface,
            onSurface: onSurface,
            error: error,
            onError: onError,
          )
        : ColorScheme.dark(
            primary: primary,
            onPrimary: onPrimary,
            secondary: secondary,
            onSecondary: onSecondary,
            surface: surface,
            onSurface: onSurface,
            error: error,
            onError: onError,
          );
  }

  @override
  Color get primary => const Color(0xFF6366F1); // Indigo

  @override
  Color get primaryVariant => const Color(0xFF4F46E5);

  @override
  Color get onPrimary => const Color(0xFFFFFFFF);

  @override
  Color get secondary => const Color(0xFFEC4899); // Pink

  @override
  Color get secondaryVariant => const Color(0xFFDB2777);

  @override
  Color get onSecondary => const Color(0xFFFFFFFF);

  @override
  Color get surface => const Color(0xFFF8FAFC);

  @override
  Color get surfaceVariant => const Color(0xFFF1F5F9);

  @override
  Color get onSurface => const Color(0xFF1E293B);

  @override
  Color get onSurfaceVariant => const Color(0xFF475569);

  @override
  Color get background => const Color(0xFFFFFFFF);

  @override
  Color get onBackground => const Color(0xFF1E293B);

  @override
  Color get error => const Color(0xFFEF4444);

  @override
  Color get errorVariant => const Color(0xFFDC2626);

  @override
  Color get onError => const Color(0xFFFFFFFF);

  @override
  Color get outline => const Color(0xFFCBD5E1);

  @override
  Color get outlineVariant => const Color(0xFFE2E8F0);

  @override
  Color get shadow => const Color(0xFF000000);

  @override
  Color get scrim => const Color(0xFF000000);

  @override
  Color get inverseSurface => const Color(0xFF1E293B);

  @override
  Color get onInverseSurface => const Color(0xFFF1F5F9);

  @override
  Color get inversePrimary => const Color(0xFF818CF8);

  @override
  Color get success => const Color(0xFF10B981);

  @override
  Color get onSuccess => const Color(0xFFFFFFFF);

  @override
  Color get warning => const Color(0xFFF59E0B);

  @override
  Color get onWarning => const Color(0xFFFFFFFF);

  @override
  Color get info => const Color(0xFF3B82F6);

  @override
  Color get onInfo => const Color(0xFFFFFFFF);
}

/// Ví dụ về cách tạo theme tùy chỉnh
class CustomThemeExample extends BaseTheme
    implements LightThemeProvider, DarkThemeProvider {
  @override
  String get id => 'custom_example';

  @override
  String get name => 'Custom Example Theme';

  @override
  String get description => 'Một theme tùy chỉnh làm ví dụ';

  @override
  bool get isDefault => false;

  @override
  bool get supportsLightMode => true;

  @override
  bool get supportsDarkMode => true;

  // Color palette cho theme
  final ColorPalette _colorPalette = ExampleColorPalette();

  // Typography system
  final ThemeTypography _typography = const ThemeTypography(
    FontConfiguration.defaultTheme,
  );

  @override
  ThemeData get lightThemeData {
    final builder = ThemeBuilder.create()
      ..withColorScheme(_colorPalette.toColorScheme(Brightness.light))
      ..withFontFamily(FontConfiguration.defaultTheme.defaultFontFamily)
      ..withTypography(_typography);
    return builder.build();
  }

  @override
  ThemeData get darkThemeData {
    final builder = ThemeBuilder.create()
      ..withColorScheme(_colorPalette.toColorScheme(Brightness.dark))
      ..withFontFamily(FontConfiguration.defaultTheme.defaultFontFamily)
      ..withTypography(_typography);
    return builder.build();
  }
}

/// Ví dụ về theme chỉ hỗ trợ light mode
class LightOnlyThemeExample extends BaseTheme implements LightThemeProvider {
  @override
  String get id => 'light_only_example';

  @override
  String get name => 'Light Only Theme';

  @override
  String get description => 'Theme chỉ hỗ trợ light mode';

  @override
  bool get supportsLightMode => true;

  @override
  ThemeData get lightThemeData {
    final colorPalette = ExampleColorPalette();
    return ThemeBuilder.create()
        .withColorScheme(colorPalette.toColorScheme(Brightness.light))
        .withFontFamily(FontConfiguration.defaultTheme.defaultFontFamily)
        .withTypography(const ThemeTypography(FontConfiguration.defaultTheme))
        .build();
  }
}

/// Ví dụ về adaptive theme
class AdaptiveThemeExample extends BaseTheme
    implements LightThemeProvider, DarkThemeProvider, AdaptiveThemeProvider {
  @override
  String get id => 'adaptive_example';

  @override
  String get name => 'Adaptive Theme';

  @override
  String get description => 'Theme tự động thích ứng với system';

  @override
  bool get supportsLightMode => true;

  @override
  bool get supportsDarkMode => true;

  @override
  bool get supportsAdaptiveMode => true;

  final ColorPalette _colorPalette = ExampleColorPalette();
  final ThemeTypography _typography = const ThemeTypography(
    FontConfiguration.defaultTheme,
  );

  @override
  ThemeData get lightThemeData => _buildTheme(Brightness.light);

  @override
  ThemeData get darkThemeData => _buildTheme(Brightness.dark);

  @override
  ThemeData getAdaptiveThemeData(Brightness brightness) =>
      _buildTheme(brightness);

  ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = _colorPalette.toColorScheme(brightness);

    return ThemeBuilder.create()
        .withColorScheme(colorScheme)
        .withFontFamily(FontConfiguration.defaultTheme.defaultFontFamily)
        .withTypography(_typography)
        .build();
  }
}

/// Ví dụ về cách sử dụng ThemeProvider
class ThemeProviderExample {
  static void demonstrateThemeProvider(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    // Lấy theme hiện tại
    final currentTheme = themeProvider.currentTheme;
    debugPrint('Current theme: ${currentTheme.name}');

    // Lấy danh sách themes có sẵn
    final availableThemes = themeProvider.availableThemes;
    debugPrint(
        'Available themes: ${availableThemes.map((t) => t.name).join(', ')}',
    );

    // Thay đổi theme
    unawaited(themeProvider.setThemeStyle('modern_elegance'));

    // Thay đổi theme mode
    unawaited(themeProvider.setThemeMode(ThemeMode.dark));

    // Kiểm tra theme mode hiện tại
    final currentMode = themeProvider.themeMode;
    debugPrint('Current theme mode: $currentMode');

    // Lấy theme data
    final lightTheme = themeProvider.lightTheme;
    final darkTheme = themeProvider.darkTheme;
  }
}

/// Ví dụ về theme validation
class ThemeValidationExample {
  static void demonstrateValidation() {
    final theme = CustomThemeExample();
    // ThemeValidator chỉ có static methods

    // Validate theme cơ bản
    final basicResult = ThemeValidator.validateTheme(theme);
    debugPrint('Theme is valid: ${basicResult.isValid}');

    if (!basicResult.isValid) {
      debugPrint('Errors:');
      for (final error in basicResult.errors) {
        debugPrint('  - $error');
      }
    }

    if (basicResult.warnings.isNotEmpty) {
      debugPrint('Warnings:');
      for (final warning in basicResult.warnings) {
        debugPrint('  - $warning');
      }
    }
  }
}

/// Ví dụ về typography caching
class TypographyExample {
  static void demonstrateTypography() {
    const typography = ThemeTypography(FontConfiguration.defaultTheme);

    // Tạo text styles với caching
    final headlineStyle = typography.getTextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: FontConfiguration.defaultTheme.defaultFontFamily,
    );

    final bodyStyle = typography.getTextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
      fontFamily: FontConfiguration.defaultTheme.defaultFontFamily,
    );

    final captionStyle = typography.getTextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
      color: Colors.grey,
      fontFamily: FontConfiguration.defaultTheme.defaultFontFamily,
    );

    // Tạo text theme với caching
    final textTheme = typography.getTextTheme(
      primaryColor: Colors.black,
      secondaryColor: Colors.grey,
      fontFamily: FontConfiguration.defaultTheme.defaultFontFamily,
    );

    debugPrint('Typography created successfully');
  }
}

/// Ví dụ về color palette validation
class ColorPaletteExample {
  static void demonstrateColorPalette() {
    // Tạo color palette hợp lệ
    final validPalette = ExampleColorPalette();

    // Tạo color schemes
    final lightColorScheme = validPalette.toColorScheme(Brightness.light);
    final darkColorScheme = validPalette.toColorScheme(Brightness.dark);

    debugPrint('Color schemes created successfully');
    debugPrint('Light scheme primary: ${lightColorScheme.primary}');
    debugPrint('Dark scheme primary: ${darkColorScheme.primary}');
  }
}

/// Ví dụ về theme constants
class ThemeConstantsExample {
  static void demonstrateConstants() {
    // Spacing constants
    debugPrint('Spacing values:');
    debugPrint('Tiny: ${ThemeConstants.tinyPadding}');
    debugPrint('Small: ${ThemeConstants.smallPadding}');
    debugPrint('Default: ${ThemeConstants.defaultPadding}');
    debugPrint('Medium: ${ThemeConstants.mediumPadding}');
    debugPrint('Large: ${ThemeConstants.largePadding}');

    // Border radius constants
    debugPrint('\nBorder radius values:');
    debugPrint('Small: ${ThemeConstants.smallRadius}');
    debugPrint('Default: ${ThemeConstants.defaultRadius}');
    debugPrint('Medium: ${ThemeConstants.mediumRadius}');
    debugPrint('Large: ${ThemeConstants.largeRadius}');
    debugPrint('Extra Large: ${ThemeConstants.extraLargeRadius}');

    // Animation constants
    debugPrint('\nAnimation durations:');
    debugPrint('Fast: ${ThemeConstants.fastAnimation.inMilliseconds}ms');
    debugPrint('Normal: ${ThemeConstants.normalAnimation.inMilliseconds}ms');
    debugPrint('Slow: ${ThemeConstants.slowAnimation.inMilliseconds}ms');

    // Validation constants
    debugPrint('\nValidation limits:');
    debugPrint(
        'Max theme creation time: ${ThemeConstants.maxThemeCreationTime}ms',
    );
    debugPrint('Min contrast ratio: ${ThemeConstants.minContrastRatio}');
    debugPrint('Max cache size: ${ThemeConstants.maxCacheSize}');
  }
}

/// Widget ví dụ sử dụng theme system
class ThemeShowcaseWidget extends StatelessWidget {
  const ThemeShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Theme Showcase'),
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
          ),
          body: Padding(
            padding: ThemeConstants.mediumPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme selector
                Card(
                  child: Padding(
                    padding: ThemeConstants.smallPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Theme',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        DropdownButton<String>(
                          value: themeProvider.currentTheme.id,
                          items: themeProvider.availableThemes
                              .map(
                                (theme) => DropdownMenuItem(
                                  value: theme.id,
                                  child: Text(theme.name),
                                ),
                              )
                              .toList(),
                          onChanged: (themeId) async {
                            if (themeId != null) {
                              await themeProvider.setThemeStyle(themeId);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Theme mode selector
                Card(
                  child: Padding(
                    padding: ThemeConstants.smallPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme Mode',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        SegmentedButton<ThemeMode>(
                          segments: const [
                            ButtonSegment(
                              value: ThemeMode.light,
                              label: Text('Light'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              label: Text('Dark'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.system,
                              label: Text('System'),
                            ),
                          ],
                          selected: {themeProvider.themeMode},
                          onSelectionChanged: (Set<ThemeMode> selection) async {
                            await themeProvider.setThemeMode(selection.first);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Color showcase
                Card(
                  child: Padding(
                    padding: ThemeConstants.smallPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Colors',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            _ColorChip(
                              color: theme.colorScheme.primary,
                              label: 'Primary',
                            ),
                            _ColorChip(
                              color: theme.colorScheme.secondary,
                              label: 'Secondary',
                            ),
                            _ColorChip(
                              color: theme.colorScheme.surface,
                              label: 'Surface',
                            ),
                            _ColorChip(
                              color: theme.colorScheme.error,
                              label: 'Error',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Typography showcase
                Card(
                  child: Padding(
                    padding: ThemeConstants.smallPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Typography',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Headline Large',
                          style: theme.textTheme.headlineLarge,
                        ),
                        Text(
                          'Title Medium',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          'Body Large',
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          'Label Small',
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Widget hiển thị color chip
class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: ThemeConstants.smallRadius,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _getContrastColor(color),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    // Simple contrast calculation
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
