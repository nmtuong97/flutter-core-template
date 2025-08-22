import 'package:flutter/material.dart';
import 'theme_configuration.dart';

/// Glassmorphism theme configuration implementation
class GlassmorphismThemeConfiguration extends ThemeConfiguration {
  GlassmorphismThemeConfiguration();

  @override
  String get themeId => 'glassmorphism';

  @override
  String get themeName => 'Glassmorphism Theme';

  @override
  String get themeDescription =>
      'Modern glassmorphism theme with frosted glass effects and transparency';

  @override
  Color get primaryColor => const Color(0xFF6366F1);

  @override
  Color get secondaryColor => const Color(0xFF8B5CF6);

  @override
  Color get backgroundColor => const Color(0xFFF8FAFC);

  @override
  Color get surfaceColor => const Color(0xFFFFFFFF).withValues(alpha: 0.25);

  @override
  Color get errorColor => const Color(0xFFEF4444);

  @override
  Color get primaryTextColor => const Color(0xFF1E293B);

  @override
  Color get secondaryTextColor => const Color(0xFF64748B);

  @override
  FontFamilyConfiguration get fontFamily =>
      const FontFamilyConfiguration.glassmorphismConfig();

  @override
  TypographyConfiguration get typography =>
      const TypographyConfiguration.glassmorphismConfig();

  @override
  ComponentConfiguration get components =>
      ComponentConfiguration.glassmorphismConfig();

  @override
  ShadowConfiguration get shadows => ShadowConfiguration.glassmorphismConfig();

  @override
  AnimationConfiguration get animations =>
      const AnimationConfiguration.glassmorphismConfig();
}

/// Glassmorphism dark theme configuration
class GlassmorphismDarkThemeConfiguration extends ThemeConfiguration {
  GlassmorphismDarkThemeConfiguration();

  @override
  String get themeId => 'glassmorphism_dark';

  @override
  String get themeName => 'Glassmorphism Dark Theme';

  @override
  String get themeDescription =>
      'Dark variant of glassmorphism theme with enhanced glass effects';

  @override
  Color get primaryColor => const Color(0xFF818CF8);

  @override
  Color get secondaryColor => const Color(0xFFA78BFA);

  @override
  Color get backgroundColor => const Color(0xFF0F172A);

  @override
  Color get surfaceColor => const Color(0xFF000000).withValues(alpha: 0.3);

  @override
  Color get errorColor => const Color(0xFFF87171);

  @override
  Color get primaryTextColor => const Color(0xFFF1F5F9);

  @override
  Color get secondaryTextColor => const Color(0xFF94A3B8);

  @override
  FontFamilyConfiguration get fontFamily =>
      const FontFamilyConfiguration.glassmorphismConfig();

  @override
  TypographyConfiguration get typography =>
      const TypographyConfiguration.glassmorphismConfig();

  @override
  ComponentConfiguration get components =>
      ComponentConfiguration.glassmorphismConfig();

  @override
  ShadowConfiguration get shadows => ShadowConfiguration.glassmorphismConfig();

  @override
  AnimationConfiguration get animations =>
      const AnimationConfiguration.glassmorphismConfig();
}
