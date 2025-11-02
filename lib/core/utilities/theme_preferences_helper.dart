import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Helper class for theme-related preferences using injected SharedPreferences.
///
/// This class provides methods to save and retrieve theme settings from local storage
/// without repeatedly calling SharedPreferences.getInstance().
///
/// Usage:
/// ```dart
/// final preferences = ThemePreferencesHelper(sharedPreferences);
/// await preferences.saveThemeMode('dark');
/// final mode = preferences.getThemeMode();
/// ```
class ThemePreferencesHelper {
  /// Creates a [ThemePreferencesHelper] with the provided [SharedPreferences] instance.
  const ThemePreferencesHelper(this._prefs);

  final SharedPreferences _prefs;

  // Keys for SharedPreferences
  static const String themeKey = 'theme_mode';
  static const String fontSizeKey = 'font_size';
  static const String fontFamilyKey = 'font_family';
  static const String themeStyleKey = 'theme_style';

  // Theme mode constants
  static const String lightTheme = 'light';
  static const String darkTheme = 'dark';
  static const String systemTheme = 'system';

  // Font size constants
  static const String smallFont = 'small';
  static const String normalFont = 'normal';
  static const String mediumFont = 'medium';
  static const String largeFont = 'large';
  static const String extraLargeFont = 'extra_large';

  // Font family constants
  static const String defaultFont = 'default';
  static const String alternateFont = 'alternate';
  static const String serifFont = 'serif';

  // Theme Mode Methods

  /// Saves the theme mode to local storage.
  ///
  /// [themeMode] should be one of: 'light', 'dark', or 'system'.
  Future<void> saveThemeMode(String themeMode) async {
    await _prefs.setString(themeKey, themeMode);
  }

  /// Gets the current theme mode from local storage.
  ///
  /// Returns 'system' if no theme mode has been saved.
  String getThemeMode() {
    return _prefs.getString(themeKey) ?? systemTheme;
  }

  // Font Size Methods

  /// Saves the font size preference to local storage.
  Future<void> saveFontSize(String fontSize) async {
    await _prefs.setString(fontSizeKey, fontSize);
  }

  /// Gets the current font size preference from local storage.
  ///
  /// Returns 'normal' if no font size has been saved.
  String getFontSize() {
    return _prefs.getString(fontSizeKey) ?? normalFont;
  }

  // Font Family Methods

  /// Saves the font family preference to local storage.
  Future<void> saveFontFamily(String fontFamily) async {
    await _prefs.setString(fontFamilyKey, fontFamily);
  }

  /// Gets the current font family preference from local storage.
  ///
  /// Returns 'default' if no font family has been saved.
  String getFontFamily() {
    return _prefs.getString(fontFamilyKey) ?? defaultFont;
  }

  // Theme Style Methods

  /// Saves the theme style preference to local storage.
  Future<void> saveThemeStyle(String themeStyle) async {
    await _prefs.setString(themeStyleKey, themeStyle);
  }

  /// Gets the current theme style preference from local storage.
  ///
  /// Returns 'default' if no theme style has been saved.
  String getThemeStyle() {
    return _prefs.getString(themeStyleKey) ?? 'default';
  }

  // Utility Methods

  /// Converts a string theme mode to [ThemeMode] enum.
  ///
  /// Returns [ThemeMode.system] for 'system' or unrecognized values.
  static ThemeMode getThemeModeFromString(String themeMode) {
    switch (themeMode) {
      case lightTheme:
        return ThemeMode.light;
      case darkTheme:
        return ThemeMode.dark;
      case systemTheme:
      default:
        return ThemeMode.system;
    }
  }

  /// Converts a [ThemeMode] enum to string.
  static String getStringFromThemeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return systemTheme;
    }
  }

  /// Converts font size string to actual numeric value.
  ///
  /// Returns the font size multiplier based on the saved preference.
  static double getFontSizeValue(String fontSize) {
    switch (fontSize) {
      case smallFont:
        return 12.0;
      case normalFont:
        return 14.0;
      case mediumFont:
        return 16.0;
      case largeFont:
        return 18.0;
      case extraLargeFont:
        return 20.0;
      default:
        return 14.0;
    }
  }
}
