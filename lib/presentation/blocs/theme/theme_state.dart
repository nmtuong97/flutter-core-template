import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/theme_entity.dart';

/// Base class for all theme states
abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the bloc is created
class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

/// State when theme data is being loaded
class ThemeLoading extends ThemeState {
  const ThemeLoading();
}

/// State when theme data is successfully loaded
class ThemeLoaded extends ThemeState {
  const ThemeLoaded({
    required this.currentTheme,
    required this.availableThemes,
    required this.themeMode,
    required this.fontSize,
    required this.fontFamily,
  });

  final ThemeEntity currentTheme;
  final List<ThemeEntity> availableThemes;
  final ThemeMode themeMode;
  final double fontSize;
  final String fontFamily;

  /// Get light theme data with current font settings
  ThemeData get lightTheme {
    final baseTheme = currentTheme.lightColors.toColorScheme();
    final textTheme = currentTheme.typography.toTextTheme();

    return ThemeData(
      colorScheme: baseTheme,
      textTheme: textTheme.apply(
        fontSizeFactor: fontSize / 14.0, // Base font size
        fontFamily: fontFamily,
      ),
      useMaterial3: true,
    );
  }

  /// Get dark theme data with current font settings
  ThemeData get darkTheme {
    final baseTheme = currentTheme.darkColors.toColorScheme();
    final textTheme = currentTheme.typography.toTextTheme();

    return ThemeData(
      colorScheme: baseTheme,
      textTheme: textTheme.apply(
        fontSizeFactor: fontSize / 14.0, // Base font size
        fontFamily: fontFamily,
      ),
      useMaterial3: true,
    );
  }

  /// Check if current theme mode is dark in the given context
  bool isDarkMode(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  /// Create a copy with modified properties
  ThemeLoaded copyWith({
    ThemeEntity? currentTheme,
    List<ThemeEntity>? availableThemes,
    ThemeMode? themeMode,
    double? fontSize,
    String? fontFamily,
  }) {
    return ThemeLoaded(
      currentTheme: currentTheme ?? this.currentTheme,
      availableThemes: availableThemes ?? this.availableThemes,
      themeMode: themeMode ?? this.themeMode,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  @override
  List<Object?> get props => [
        currentTheme,
        availableThemes,
        themeMode,
        fontSize,
        fontFamily,
      ];
}

/// State when theme operation is in progress
class ThemeOperationInProgress extends ThemeState {
  const ThemeOperationInProgress({
    required this.operation,
    this.previousState,
  });

  final String operation;
  final ThemeLoaded? previousState;

  @override
  List<Object?> get props => [operation, previousState];
}

/// State when theme operation is successful
class ThemeOperationSuccess extends ThemeState {
  const ThemeOperationSuccess({
    required this.message,
    required this.updatedState,
  });

  final String message;
  final ThemeLoaded updatedState;

  @override
  List<Object?> get props => [message, updatedState];
}

/// State when an error occurs
class ThemeError extends ThemeState {
  const ThemeError({
    required this.message,
    required this.code,
    this.previousState,
  });

  final String message;
  final String code;
  final ThemeLoaded? previousState;

  @override
  List<Object?> get props => [message, code, previousState];
}
