import 'package:flutter_theme_showcase/theme/base/app_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/cyberpunk_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/default_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/exaggerated_minimalism_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/glassmorphism_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/neumorphism_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/night_sky_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/organic_natural_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/retro_vintage_theme.dart';

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
