import 'package:flutter/material.dart';
import 'theme_configuration.dart';

/// Default theme configuration implementation
class DefaultThemeConfiguration extends ThemeConfiguration {
  DefaultThemeConfiguration();

  @override
  String get themeId => 'default';

  @override
  String get themeName => 'Default Theme';

  @override
  String get themeDescription =>
      'Clean and modern default theme with Material Design principles';

  @override
  Color get primaryColor => const Color(0xFF2196F3);

  @override
  Color get secondaryColor => const Color(0xFF03DAC6);

  @override
  Color get backgroundColor => const Color(0xFFFAFAFA);

  @override
  Color get surfaceColor => Colors.white;

  @override
  Color get errorColor => const Color(0xFFB00020);

  @override
  Color get primaryTextColor => const Color(0xFF212121);

  @override
  Color get secondaryTextColor => const Color(0xFF757575);

  @override
  FontFamilyConfiguration get fontFamily =>
      const FontFamilyConfiguration.defaultConfig();

  @override
  TypographyConfiguration get typography =>
      const TypographyConfiguration.defaultConfig();

  @override
  ComponentConfiguration get components =>
      ComponentConfiguration.defaultConfig();

  @override
  ShadowConfiguration get shadows => ShadowConfiguration.defaultConfig();

  @override
  AnimationConfiguration get animations =>
      const AnimationConfiguration.defaultConfig();
}

/// Default dark theme configuration implementation
class DefaultDarkThemeConfiguration extends ThemeConfiguration {
  DefaultDarkThemeConfiguration();

  @override
  String get themeId => 'default_dark';

  @override
  String get themeName => 'Default Dark Theme';

  @override
  String get themeDescription =>
      'Clean and modern dark theme with Material Design principles';

  @override
  Color get primaryColor => const Color(0xFF90CAF9);

  @override
  Color get secondaryColor => const Color(0xFF03DAC6);

  @override
  Color get backgroundColor => const Color(0xFF121212);

  @override
  Color get surfaceColor => const Color(0xFF1E1E1E);

  @override
  Color get errorColor => const Color(0xFFCF6679);

  @override
  Color get primaryTextColor => Colors.white;

  @override
  Color get secondaryTextColor => const Color(0xFFB3B3B3);

  @override
  FontFamilyConfiguration get fontFamily =>
      const FontFamilyConfiguration.defaultConfig();

  @override
  TypographyConfiguration get typography =>
      const TypographyConfiguration.defaultConfig();

  @override
  ComponentConfiguration get components =>
      ComponentConfiguration.defaultConfig();

  @override
  ShadowConfiguration get shadows => ShadowConfiguration.defaultConfig();

  @override
  AnimationConfiguration get animations =>
      const AnimationConfiguration.defaultConfig();
}
