import 'package:flutter/material.dart';
import 'theme_configuration.dart';

/// Cyberpunk theme configuration implementation
class CyberpunkThemeConfiguration extends ThemeConfiguration {
  CyberpunkThemeConfiguration();

  @override
  String get themeId => 'cyberpunk';

  @override
  String get themeName => 'Cyberpunk Theme';

  @override
  String get themeDescription =>
      'Futuristic cyberpunk theme with neon colors and glow effects';

  @override
  Color get primaryColor => const Color(0xFF00FFFF);

  @override
  Color get secondaryColor => const Color(0xFFFF0080);

  @override
  Color get backgroundColor => const Color(0xFF0A0A0A);

  @override
  Color get surfaceColor => const Color(0xFF1A1A1A);

  @override
  Color get errorColor => const Color(0xFFFF0040);

  @override
  Color get primaryTextColor => const Color(0xFF00FFFF);

  @override
  Color get secondaryTextColor => const Color(0xFFB0B0B0);

  @override
  FontFamilyConfiguration get fontFamily =>
      const FontFamilyConfiguration.cyberpunkConfig();

  @override
  TypographyConfiguration get typography =>
      const TypographyConfiguration.cyberpunkConfig();

  @override
  ComponentConfiguration get components =>
      ComponentConfiguration.cyberpunkConfig();

  @override
  ShadowConfiguration get shadows => ShadowConfiguration.cyberpunkConfig();

  @override
  AnimationConfiguration get animations =>
      const AnimationConfiguration.cyberpunkConfig();
}

/// Cyberpunk dark theme configuration (alternative variant)
class CyberpunkDarkThemeConfiguration extends ThemeConfiguration {
  CyberpunkDarkThemeConfiguration();

  @override
  String get themeId => 'cyberpunk_dark';

  @override
  String get themeName => 'Cyberpunk Dark Theme';

  @override
  String get themeDescription =>
      'Darker variant of cyberpunk theme with enhanced neon effects';

  @override
  Color get primaryColor => const Color(0xFF00FF41);

  @override
  Color get secondaryColor => const Color(0xFFFF6B35);

  @override
  Color get backgroundColor => const Color(0xFF000000);

  @override
  Color get surfaceColor => const Color(0xFF111111);

  @override
  Color get errorColor => const Color(0xFFFF073A);

  @override
  Color get primaryTextColor => const Color(0xFF00FF41);

  @override
  Color get secondaryTextColor => const Color(0xFF888888);

  @override
  FontFamilyConfiguration get fontFamily =>
      const FontFamilyConfiguration.cyberpunkConfig();

  @override
  TypographyConfiguration get typography =>
      const TypographyConfiguration.cyberpunkConfig();

  @override
  ComponentConfiguration get components =>
      ComponentConfiguration.cyberpunkConfig();

  @override
  ShadowConfiguration get shadows => ShadowConfiguration.cyberpunkConfig();

  @override
  AnimationConfiguration get animations =>
      const AnimationConfiguration.cyberpunkConfig();
}
