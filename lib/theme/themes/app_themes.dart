import '../base/app_theme.dart';
import 'cyberpunk_theme.dart';
import 'default_theme.dart';
import 'exaggerated_minimalism_theme.dart';
import 'glassmorphism_theme.dart';
import 'neumorphism_theme.dart';
import 'night_sky_theme.dart';
import 'organic_natural_theme.dart';
import 'retro_vintage_theme.dart';

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
