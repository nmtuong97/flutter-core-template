import 'package:flutter/material.dart';
import 'theme_configuration.dart';

/// Neumorphism theme configuration implementation
class NeumorphismThemeConfiguration extends ThemeConfiguration {
  NeumorphismThemeConfiguration();

  @override
  String get themeId => 'neumorphism';

  @override
  String get themeName => 'Neumorphism Theme';

  @override
  String get themeDescription =>
      'Soft neumorphism theme with subtle shadows and embossed effects';

  @override
  Color get primaryColor => const Color(0xFF5B9BD5);

  @override
  Color get secondaryColor => const Color(0xFF70AD47);

  @override
  Color get backgroundColor => const Color(0xFFE6E6E6);

  @override
  Color get surfaceColor => const Color(0xFFE6E6E6);

  @override
  Color get errorColor => const Color(0xFFE74C3C);

  @override
  Color get primaryTextColor => const Color(0xFF2C3E50);

  @override
  Color get secondaryTextColor => const Color(0xFF7F8C8D);

  @override
  FontFamilyConfiguration get fontFamily =>
      const FontFamilyConfiguration.neumorphismConfig();

  @override
  TypographyConfiguration get typography =>
      const TypographyConfiguration.neumorphismConfig();

  @override
  ComponentConfiguration get components =>
      ComponentConfiguration.neumorphismConfig();

  @override
  ShadowConfiguration get shadows => ShadowConfiguration.neumorphismConfig();

  @override
  AnimationConfiguration get animations =>
      const AnimationConfiguration.neumorphismConfig();
}

/// Neumorphism dark theme configuration
class NeumorphismDarkThemeConfiguration extends ThemeConfiguration {
  NeumorphismDarkThemeConfiguration();

  @override
  String get themeId => 'neumorphism_dark';

  @override
  String get themeName => 'Neumorphism Dark Theme';

  @override
  String get themeDescription =>
      'Dark variant of neumorphism theme with enhanced shadow effects';

  @override
  Color get primaryColor => const Color(0xFF74A9D8);

  @override
  Color get secondaryColor => const Color(0xFF8BC34A);

  @override
  Color get backgroundColor => const Color(0xFF2C2C2C);

  @override
  Color get surfaceColor => const Color(0xFF2C2C2C);

  @override
  Color get errorColor => const Color(0xFFE57373);

  @override
  Color get primaryTextColor => const Color(0xFFECF0F1);

  @override
  Color get secondaryTextColor => const Color(0xFFBDC3C7);

  @override
  FontFamilyConfiguration get fontFamily =>
      const FontFamilyConfiguration.neumorphismConfig();

  @override
  TypographyConfiguration get typography =>
      const TypographyConfiguration.neumorphismConfig();

  @override
  ComponentConfiguration get components =>
      ComponentConfiguration.neumorphismConfig();

  @override
  ShadowConfiguration get shadows => ShadowConfiguration.neumorphismConfig();

  @override
  AnimationConfiguration get animations =>
      const AnimationConfiguration.neumorphismConfig();
}
