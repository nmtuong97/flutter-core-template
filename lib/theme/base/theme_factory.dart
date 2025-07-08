import '../themes/cyberpunk_theme.dart';
import '../themes/default_theme.dart';
import '../themes/exaggerated_minimalism_theme.dart';
import '../themes/glassmorphism_theme.dart';
import '../themes/neumorphism_theme.dart';
import '../themes/night_sky_theme.dart';
import '../themes/organic_natural_theme.dart';
import '../themes/retro_vintage_theme.dart';
import 'app_theme.dart';

/// Factory class để tạo và quản lý các theme
class ThemeFactory {
  // Danh sách tất cả các theme có sẵn
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

  /// Lấy danh sách tất cả các theme có sẵn
  static List<AppTheme> get availableThemes => _availableThemes;

  /// Lấy theme mặc định
  static AppTheme get defaultTheme => _availableThemes.firstWhere(
        (theme) => theme.isDefault,
        orElse: () => _availableThemes.first,
      );

  /// Lấy theme theo ID
  static AppTheme getThemeById(String id) {
    return _availableThemes.firstWhere(
      (theme) => theme.id == id,
      orElse: () => defaultTheme,
    );
  }
}
