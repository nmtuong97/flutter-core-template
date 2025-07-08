import 'package:flutter_theme_showcase/theme/base/app_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/cyberpunk_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/default_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/exaggerated_minimalism_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/glassmorphism_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/neumorphism_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/night_sky_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/organic_natural_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/retro_vintage_theme.dart';

class AppThemes {
  static List<AppTheme> get all {
    return [
      DefaultTheme(),
      CyberpunkTheme(),
      ExaggeratedMinimalismTheme(),
      GlassmorphismTheme(),
      NeumorphismTheme(),
      NightSkyTheme(),
      OrganicNaturalTheme(),
      RetroVintageTheme(),
    ];
  }
}
