import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/base/app_theme.dart';
import '../theme/themes/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  double _fontSize = 16;
  String _fontFamily = 'Roboto';
  AppTheme _currentAppTheme = AppThemes.all.firstWhere(
    (theme) => theme.isDefault,
    orElse: () => AppThemes.all.first,
  );

  ThemeMode get themeMode => _themeMode;
  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;
  AppTheme get currentAppTheme => _currentAppTheme;

  ThemeData get lightTheme => _currentAppTheme.lightThemeData.copyWith(
        textTheme: _currentAppTheme.lightThemeData.textTheme
            .copyWith(
              bodyLarge: _currentAppTheme.lightThemeData.textTheme.bodyLarge
                  ?.copyWith(fontSize: _fontSize),
              bodyMedium: _currentAppTheme.lightThemeData.textTheme.bodyMedium
                  ?.copyWith(fontSize: _fontSize - 2),
              bodySmall: _currentAppTheme.lightThemeData.textTheme.bodySmall
                  ?.copyWith(fontSize: _fontSize - 4),
            )
            .apply(fontFamily: _fontFamily),
      );

  ThemeData get darkTheme => _currentAppTheme.darkThemeData.copyWith(
        textTheme: _currentAppTheme.darkThemeData.textTheme
            .copyWith(
              bodyLarge: _currentAppTheme.darkThemeData.textTheme.bodyLarge
                  ?.copyWith(fontSize: _fontSize),
              bodyMedium: _currentAppTheme.darkThemeData.textTheme.bodyMedium
                  ?.copyWith(fontSize: _fontSize - 2),
              bodySmall: _currentAppTheme.darkThemeData.textTheme.bodySmall
                  ?.copyWith(fontSize: _fontSize - 4),
            )
            .apply(fontFamily: _fontFamily),
      );

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _savePreferences();
  }

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
    _savePreferences();
  }

  void setFontFamily(String family) {
    _fontFamily = family;
    notifyListeners();
    _savePreferences();
  }

  void setAppTheme(AppTheme theme) {
    _currentAppTheme = theme;
    notifyListeners();
    _savePreferences();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeMode.toString());
    await prefs.setDouble('fontSize', _fontSize);
    await prefs.setString('fontFamily', _fontFamily);
    await prefs.setString('appThemeId', _currentAppTheme.id);
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? 'ThemeMode.system';
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    _fontFamily = prefs.getString('fontFamily') ?? 'Roboto';
    final appThemeId = prefs.getString('appThemeId');

    if (appThemeId != null) {
      _currentAppTheme = AppThemes.all.firstWhere(
        (theme) => theme.id == appThemeId,
        orElse: () => AppThemes.all.firstWhere(
          (theme) => theme.isDefault,
          orElse: () => AppThemes.all.first,
        ),
      );
    }

    switch (themeModeString) {
      case 'ThemeMode.light':
        _themeMode = ThemeMode.light;
      case 'ThemeMode.dark':
        _themeMode = ThemeMode.dark;
      default:
        _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}
