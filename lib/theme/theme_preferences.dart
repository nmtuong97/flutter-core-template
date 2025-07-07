import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String themeKey = 'theme_mode';
  static const String fontSizeKey = 'font_size';
  static const String fontFamilyKey = 'font_family';
  static const String languageKey = 'language_code';

  // Theme mode
  static const String lightTheme = 'light';
  static const String darkTheme = 'dark';
  static const String systemTheme = 'system';

  // Theme style
  static const String themeStyleKey = 'theme_style';

  // Theme IDs - Không cần định nghĩa cứng ở đây nữa, sẽ lấy từ ThemeFactory

  // Font size
  static const String smallFont = 'small';
  static const String normalFont = 'normal';
  static const String mediumFont = 'medium';
  static const String largeFont = 'large';
  static const String extraLargeFont = 'extra_large';

  // Font family
  static const String defaultFont = 'default';
  static const String alternateFont = 'alternate';
  static const String serifFont = 'serif';

  // Language
  static const String englishLanguage = 'en';
  static const String vietnameseLanguage = 'vi';

  // Save theme mode
  static Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, themeMode);
  }

  // Get theme mode
  static Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeKey) ?? systemTheme;
  }

  // Save font size
  static Future<void> saveFontSize(String fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(fontSizeKey, fontSize);
  }

  // Get font size
  static Future<String> getFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(fontSizeKey) ?? normalFont;
  }

  // Save font family
  static Future<void> saveFontFamily(String fontFamily) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(fontFamilyKey, fontFamily);
  }

  // Get font family
  static Future<String> getFontFamily() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(fontFamilyKey) ?? defaultFont;
  }

  // Save theme style
  static Future<void> saveThemeStyle(String themeStyle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeStyleKey, themeStyle);
  }

  // Get theme style
  static Future<String> getThemeStyle() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeStyleKey) ?? 'default';
  }

  // Convert string theme mode to ThemeMode
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

  // Convert string font size to double
  static double getFontSizeFromString(String fontSize) {
    switch (fontSize) {
      case smallFont:
        return 12;
      case mediumFont:
        return 16;
      case largeFont:
        return 18;
      case extraLargeFont:
        return 22;
      case normalFont:
      default:
        return 14;
    }
  }

  // Convert string font family to actual font family
  static String getFontFamilyFromString(String fontFamily) {
    switch (fontFamily) {
      case alternateFont:
        return 'Poppins';
      case serifFont:
        return 'Merriweather';
      case defaultFont:
      default:
        return 'Roboto';
    }
  }
}
