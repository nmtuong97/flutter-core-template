import 'package:flutter/material.dart';
import 'package:flutter_theme_showcase/theme/base/app_theme.dart';
import 'package:flutter_theme_showcase/theme/base/theme_factory.dart';
import 'package:flutter_theme_showcase/theme/theme_preferences.dart';
import 'package:flutter_theme_showcase/theme/themes/default_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadPreferences();
  }
  ThemeMode _themeMode = ThemeMode.system;
  double _fontSize = DefaultTheme.normalFontSize;
  String _fontFamily = DefaultTheme.defaultFontFamily;
  AppTheme _currentTheme = DefaultTheme();

  bool _isLoading = true;

  ThemeMode get themeMode => _themeMode;
  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;
  String get themeId => _currentTheme.id;
  AppTheme get currentTheme => _currentTheme;
  bool get isLoading => _isLoading;

  // Lấy danh sách tất cả các theme có sẵn
  List<AppTheme> get availableThemes => ThemeFactory.availableThemes;

  // Get current theme data
  ThemeData get lightTheme => _currentTheme.lightThemeData.copyWith(
        textTheme: _currentTheme.lightThemeData.textTheme.apply(
          fontSizeFactor: _fontSize / DefaultTheme.normalFontSize,
          fontFamily: _fontFamily,
        ),
      );

  ThemeData get darkTheme => _currentTheme.darkThemeData.copyWith(
        textTheme: _currentTheme.darkThemeData.textTheme.apply(
          fontSizeFactor: _fontSize / DefaultTheme.normalFontSize,
          fontFamily: _fontFamily,
        ),
      );

  // Load saved preferences
  Future<void> _loadPreferences() async {
    final themeMode = await ThemePreferences.getThemeMode();
    final fontSize = await ThemePreferences.getFontSize();
    final fontFamily = await ThemePreferences.getFontFamily();
    final themeId = await ThemePreferences.getThemeStyle();

    _themeMode = ThemePreferences.getThemeModeFromString(themeMode);
    _fontSize = ThemePreferences.getFontSizeFromString(fontSize);
    _fontFamily = ThemePreferences.getFontFamilyFromString(fontFamily);
    _currentTheme = ThemeFactory.getThemeById(themeId);
    _isLoading = false;

    notifyListeners();
  }

  // Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    String themeModeString;
    switch (mode) {
      case ThemeMode.light:
        themeModeString = ThemePreferences.lightTheme;
      case ThemeMode.dark:
        themeModeString = ThemePreferences.darkTheme;
      case ThemeMode.system:
        themeModeString = ThemePreferences.systemTheme;
    }

    await ThemePreferences.saveThemeMode(themeModeString);
  }

  // Set font size
  Future<void> setFontSize(String fontSizeString) async {
    final newFontSize = ThemePreferences.getFontSizeFromString(fontSizeString);
    _fontSize = newFontSize;
    notifyListeners();

    await ThemePreferences.saveFontSize(fontSizeString);
  }

  // Set font family
  Future<void> setFontFamily(String fontFamilyString) async {
    final newFontFamily = ThemePreferences.getFontFamilyFromString(
      fontFamilyString,
    );
    _fontFamily = newFontFamily;
    notifyListeners();

    await ThemePreferences.saveFontFamily(fontFamilyString);
  }

  // Set theme style
  Future<void> setThemeStyle(String themeId) async {
    _currentTheme = ThemeFactory.getThemeById(themeId);
    notifyListeners();

    await ThemePreferences.saveThemeStyle(themeId);
  }

  // Toggle theme mode between light and dark
  Future<void> toggleThemeMode() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else {
      await setThemeMode(ThemeMode.light);
    }
  }

  // Check if theme is dark
  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
}
