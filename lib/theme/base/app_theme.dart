import 'package:flutter/material.dart';

import 'theme_interfaces.dart';

/// Abstract base class for all application themes
/// Provides a consistent interface for theme implementation
/// Now extends BaseTheme and implements required interfaces
abstract class AppTheme extends BaseTheme
    implements LightThemeProvider, DarkThemeProvider {
  /// Light theme data
  @override
  ThemeData get lightThemeData;

  /// Dark theme data
  @override
  ThemeData get darkThemeData;

  /// Get theme data based on brightness
  ThemeData getThemeData(Brightness brightness) {
    return brightness == Brightness.light ? lightThemeData : darkThemeData;
  }

  /// Validate theme consistency
  bool validateTheme() {
    try {
      // Basic validation - ensure themes can be created
      lightThemeData;
      final dark = darkThemeData;

      // Check if themes have required properties
      return dark.colorScheme.primary != Colors.transparent;
    } on Exception catch (_) {
      return false;
    }
  }

  /// Get theme capabilities
  ThemeCapabilities get capabilities => ThemeCapabilities(this);
}
