import 'package:flutter/material.dart';

import '../configurations/cyberpunk_theme_configuration.dart';
import '../configurations/default_theme_configuration.dart';
import '../configurations/glassmorphism_theme_configuration.dart';
import '../configurations/neumorphism_theme_configuration.dart';
import '../configurations/theme_configuration.dart';
import 'theme_helper.dart';
import 'theme_utilities.dart';

/// Factory class for creating theme data from configurations
/// Centralizes theme creation logic and eliminates code duplication
class ThemeFactory {
  const ThemeFactory._();

  // ==================== THEME CREATION ====================

  /// Create ThemeData from configuration
  static ThemeData createTheme({
    required ThemeConfiguration config,
    required Brightness brightness,
    double? screenWidth,
  }) {
    final colorScheme = ThemeUtilities.createColorScheme(
      config: config,
      brightness: brightness,
    );

    final textTheme = ThemeHelper.createTextTheme(
      config: config,
      screenWidth: screenWidth,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,

      // Component themes
      appBarTheme: ThemeHelper.createAppBarTheme(config),
      elevatedButtonTheme: ThemeHelper.createElevatedButtonTheme(config),
      cardTheme: ThemeHelper.createCardTheme(config),
      inputDecorationTheme: ThemeHelper.createInputDecorationTheme(config),

      // Additional theme properties
      scaffoldBackgroundColor: config.backgroundColor,
      canvasColor: config.surfaceColor,
      dividerColor: config.primaryColor.withValues(alpha: 0.2),
      focusColor: config.primaryColor.withValues(alpha: 0.1),
      hoverColor: config.primaryColor.withValues(alpha: 0.05),
      splashColor: config.primaryColor.withValues(alpha: 0.1),
      highlightColor: config.primaryColor.withValues(alpha: 0.05),

      // Visual density and interaction
      visualDensity: VisualDensity.adaptivePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.padded,

      // Extensions for custom themes
      extensions: _createThemeExtensions(config),
    );
  }

  /// Create theme extensions for custom properties
  static List<ThemeExtension> _createThemeExtensions(
    ThemeConfiguration config,
  ) {
    return [
      CustomThemeExtension(
        glassOpacity: config.components.glassOpacity,
        hasGlassEffect: config.components.hasGlassEffect,
        hasNeumorphismEffect: config.components.hasNeumorphismEffect,
        hasNeonGlow: config.shadows.hasNeonGlow,
        neonGlowColor: config.shadows.neonGlowColor,
        animationCurve: config.animations.curve,
        customTransitions: config.animations.hasCustomTransitions,
      ),
    ];
  }

  // ==================== PREDEFINED THEMES ====================

  /// Create default light theme
  static ThemeData createDefaultLightTheme({double? screenWidth}) {
    return createTheme(
      config: DefaultThemeConfiguration(),
      brightness: Brightness.light,
      screenWidth: screenWidth,
    );
  }

  /// Create default dark theme
  static ThemeData createDefaultDarkTheme({double? screenWidth}) {
    return createTheme(
      config: DefaultDarkThemeConfiguration(),
      brightness: Brightness.dark,
      screenWidth: screenWidth,
    );
  }

  /// Create cyberpunk light theme
  static ThemeData createCyberpunkLightTheme({double? screenWidth}) {
    return createTheme(
      config: CyberpunkThemeConfiguration(),
      brightness: Brightness.light,
      screenWidth: screenWidth,
    );
  }

  /// Create cyberpunk dark theme
  static ThemeData createCyberpunkDarkTheme({double? screenWidth}) {
    return createTheme(
      config: CyberpunkDarkThemeConfiguration(),
      brightness: Brightness.dark,
      screenWidth: screenWidth,
    );
  }

  /// Create glassmorphism light theme
  static ThemeData createGlassmorphismLightTheme({double? screenWidth}) {
    return createTheme(
      config: GlassmorphismThemeConfiguration(),
      brightness: Brightness.light,
      screenWidth: screenWidth,
    );
  }

  /// Create glassmorphism dark theme
  static ThemeData createGlassmorphismDarkTheme({double? screenWidth}) {
    return createTheme(
      config: GlassmorphismDarkThemeConfiguration(),
      brightness: Brightness.dark,
      screenWidth: screenWidth,
    );
  }

  /// Create neumorphism light theme
  static ThemeData createNeumorphismLightTheme({double? screenWidth}) {
    return createTheme(
      config: NeumorphismThemeConfiguration(),
      brightness: Brightness.light,
      screenWidth: screenWidth,
    );
  }

  /// Create neumorphism dark theme
  static ThemeData createNeumorphismDarkTheme({double? screenWidth}) {
    return createTheme(
      config: NeumorphismDarkThemeConfiguration(),
      brightness: Brightness.dark,
      screenWidth: screenWidth,
    );
  }

  // ==================== THEME UTILITIES ====================

  /// Get available theme configurations
  static Map<String, ThemeConfiguration> getAvailableThemes() {
    return {
      'default_light': DefaultThemeConfiguration(),
      'default_dark': DefaultDarkThemeConfiguration(),
      'cyberpunk_light': CyberpunkThemeConfiguration(),
      'cyberpunk_dark': CyberpunkDarkThemeConfiguration(),
      'glassmorphism_light': GlassmorphismThemeConfiguration(),
      'glassmorphism_dark': GlassmorphismDarkThemeConfiguration(),
      'neumorphism_light': NeumorphismThemeConfiguration(),
      'neumorphism_dark': NeumorphismDarkThemeConfiguration(),
    };
  }

  /// Create theme by ID
  static ThemeData? createThemeById({
    required String themeId,
    double? screenWidth,
  }) {
    final themes = getAvailableThemes();
    final config = themes[themeId];

    if (config == null) return null;

    final brightness =
        themeId.contains('dark') ? Brightness.dark : Brightness.light;

    return createTheme(
      config: config,
      brightness: brightness,
      screenWidth: screenWidth,
    );
  }

  /// Validate theme configuration before creation
  static List<String> validateConfiguration(ThemeConfiguration config) {
    return ThemeUtilities.validateThemeConfiguration(config);
  }

  /// Performance test for theme creation
  static Map<String, dynamic> benchmarkThemeCreation(
    ThemeConfiguration config,
  ) {
    final stopwatch = Stopwatch()..start();

    final theme = createTheme(
      config: config,
      brightness: Brightness.light,
    );

    stopwatch.stop();

    return {
      'creationTime': stopwatch.elapsedMilliseconds,
      'isPerformant':
          ThemeUtilities.validateThemePerformance(stopwatch.elapsed),
      'themeData': theme,
      'analysis': ThemeHelper.analyzeThemePerformance(theme),
    };
  }
}

/// Custom theme extension for additional properties
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  const CustomThemeExtension({
    required this.glassOpacity,
    required this.hasGlassEffect,
    required this.hasNeumorphismEffect,
    required this.hasNeonGlow,
    required this.animationCurve,
    required this.customTransitions,
    this.neonGlowColor,
  });

  final double glassOpacity;
  final bool hasGlassEffect;
  final bool hasNeumorphismEffect;
  final bool hasNeonGlow;
  final Color? neonGlowColor;
  final Curve animationCurve;
  final bool customTransitions;

  @override
  CustomThemeExtension copyWith({
    double? glassOpacity,
    bool? hasGlassEffect,
    bool? hasNeumorphismEffect,
    bool? hasNeonGlow,
    Color? neonGlowColor,
    Curve? animationCurve,
    bool? customTransitions,
  }) {
    return CustomThemeExtension(
      glassOpacity: glassOpacity ?? this.glassOpacity,
      hasGlassEffect: hasGlassEffect ?? this.hasGlassEffect,
      hasNeumorphismEffect: hasNeumorphismEffect ?? this.hasNeumorphismEffect,
      hasNeonGlow: hasNeonGlow ?? this.hasNeonGlow,
      neonGlowColor: neonGlowColor ?? this.neonGlowColor,
      animationCurve: animationCurve ?? this.animationCurve,
      customTransitions: customTransitions ?? this.customTransitions,
    );
  }

  @override
  CustomThemeExtension lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }

    return CustomThemeExtension(
      glassOpacity:
          lerpDouble(glassOpacity, other.glassOpacity, t) ?? glassOpacity,
      hasGlassEffect: hasGlassEffect,
      hasNeumorphismEffect: hasNeumorphismEffect,
      hasNeonGlow: hasNeonGlow,
      neonGlowColor: Color.lerp(neonGlowColor, other.neonGlowColor, t),
      animationCurve: animationCurve,
      customTransitions: customTransitions,
    );
  }
}

/// Helper function for double interpolation
double? lerpDouble(double? a, double? b, double t) {
  if (a == null && b == null) return null;
  final localA = a ?? 0.0;
  final localB = b ?? 0.0;
  return localA + (localB - localA) * t;
}
