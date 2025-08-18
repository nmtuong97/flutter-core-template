import '../themes/cyberpunk_theme.dart';
import '../themes/default_theme.dart';
import '../themes/exaggerated_minimalism_theme.dart';
import '../themes/glassmorphism_theme.dart';
import '../themes/neumorphism_theme.dart';
import '../themes/night_sky_theme.dart';
import '../themes/organic_natural_theme.dart';
import '../themes/retro_vintage_theme.dart';
import 'app_theme.dart';

/// Factory class to create and manage themes
class ThemeFactory {
  // List of all available themes
  static final List<AppTheme> _availableThemes = [
    DefaultTheme(),
    CyberpunkTheme(),
    NightSkyTheme(),
    ExaggeratedMinimalismTheme(),
    NeumorphismTheme(),
    GlassmorphismTheme(),
    RetroVintageTheme(),
    OrganicNaturalTheme(),
    // Thêm các theme mới ở đây
  ];

  /// Get list of all available themes
  static List<AppTheme> get availableThemes => _availableThemes;

  /// Get default theme
  static AppTheme get defaultTheme => _availableThemes.firstWhere(
        (theme) => theme.isDefault,
        orElse: () => _availableThemes.first,
      );

  /// Get theme by ID
  static AppTheme getThemeById(String id) {
    return _availableThemes.firstWhere(
      (theme) => theme.id == id,
      orElse: () => defaultTheme,
    );
  }
}
