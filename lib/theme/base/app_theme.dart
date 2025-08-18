import 'package:flutter/material.dart';

/// Abstract class defining the basic structure for all themes
@immutable
abstract class AppTheme {
  /// Unique ID of the theme, used for storage and identification
  String get id;

  /// Display name of the theme
  String get name;

  /// Short description of the theme
  String get description;

  /// Light theme data
  ThemeData get lightThemeData;

  /// Dark theme data
  ThemeData get darkThemeData;

  /// Check if this theme is the default theme
  bool get isDefault => false;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
