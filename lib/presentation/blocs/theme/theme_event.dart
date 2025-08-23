import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Base class for all theme events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load the current theme
class ThemeLoadCurrentEvent extends ThemeEvent {
  const ThemeLoadCurrentEvent();
}

/// Event to load all available themes
class ThemeLoadAvailableEvent extends ThemeEvent {
  const ThemeLoadAvailableEvent();
}

/// Event to switch to a different theme
class ThemeSwitchEvent extends ThemeEvent {
  const ThemeSwitchEvent({
    required this.themeId,
  });

  final String themeId;

  @override
  List<Object?> get props => [themeId];
}

/// Event to change theme mode (light, dark, system)
class ThemeChangeModeEvent extends ThemeEvent {
  const ThemeChangeModeEvent({
    required this.themeMode,
  });

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

/// Event to toggle between light and dark mode
class ThemeToggleModeEvent extends ThemeEvent {
  const ThemeToggleModeEvent();
}

/// Event to change font size
class ThemeChangeFontSizeEvent extends ThemeEvent {
  const ThemeChangeFontSizeEvent({
    required this.fontSize,
  });

  final double fontSize;

  @override
  List<Object?> get props => [fontSize];
}

/// Event to change font family
class ThemeChangeFontFamilyEvent extends ThemeEvent {
  const ThemeChangeFontFamilyEvent({
    required this.fontFamily,
  });

  final String fontFamily;

  @override
  List<Object?> get props => [fontFamily];
}

/// Event to reset theme to default
class ThemeResetToDefaultEvent extends ThemeEvent {
  const ThemeResetToDefaultEvent();
}

/// Event to save a custom theme
class ThemeSaveCustomEvent extends ThemeEvent {
  const ThemeSaveCustomEvent({
    required this.themeId,
    required this.themeName,
    required this.themeDescription,
  });

  final String themeId;
  final String themeName;
  final String themeDescription;

  @override
  List<Object?> get props => [themeId, themeName, themeDescription];
}

/// Event to delete a custom theme
class ThemeDeleteCustomEvent extends ThemeEvent {
  const ThemeDeleteCustomEvent({
    required this.themeId,
  });

  final String themeId;

  @override
  List<Object?> get props => [themeId];
}
