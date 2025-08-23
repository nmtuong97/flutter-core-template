import 'package:flutter/material.dart';

import '../../core/errors/result.dart';
import '../entities/theme_entity.dart';

/// Repository interface for theme operations
abstract class ThemeRepository {
  /// Get the current active theme
  FutureResult<ThemeEntity> getCurrentTheme();

  /// Get all available themes
  FutureResult<List<ThemeEntity>> getAvailableThemes();

  /// Get a specific theme by ID
  FutureResult<ThemeEntity> getThemeById(String themeId);

  /// Save/update a theme
  FutureResult<void> saveTheme(ThemeEntity theme);

  /// Delete a theme (only custom themes)
  FutureResult<void> deleteTheme(String themeId);

  /// Set the current active theme
  FutureResult<void> setCurrentTheme(String themeId);

  /// Get the current theme mode
  FutureResult<ThemeMode> getCurrentThemeMode();

  /// Set the theme mode
  FutureResult<void> setThemeMode(ThemeMode themeMode);

  /// Get the current font size
  FutureResult<double> getCurrentFontSize();

  /// Set the font size
  FutureResult<void> setFontSize(double fontSize);

  /// Get the current font family
  FutureResult<String> getCurrentFontFamily();

  /// Set the font family
  FutureResult<void> setFontFamily(String fontFamily);

  /// Check if a theme exists
  FutureResult<bool> themeExists(String themeId);

  /// Get theme preferences as a map
  FutureResult<Map<String, dynamic>> getThemePreferences();

  /// Save theme preferences
  FutureResult<void> saveThemePreferences(Map<String, dynamic> preferences);

  /// Reset theme to default
  FutureResult<void> resetToDefault();

  /// Cache a theme for performance
  FutureResult<void> cacheTheme(ThemeEntity theme);

  /// Clear theme cache
  FutureResult<void> clearCache();
}
