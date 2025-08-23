import 'package:flutter/material.dart';

import '../../../core/errors/result.dart';
import '../../repositories/theme_repository.dart';

/// Use case for managing theme mode (light, dark, system)
class ManageThemeModeUseCase {
  const ManageThemeModeUseCase({
    required this.repository,
  });

  final ThemeRepository repository;

  /// Get current theme mode
  FutureResult<ThemeMode> getCurrentThemeMode() async {
    return repository.getCurrentThemeMode();
  }

  /// Set theme mode
  FutureResult<void> setThemeMode(ThemeMode themeMode) async {
    return repository.setThemeMode(themeMode);
  }

  /// Toggle between light and dark mode
  FutureResult<ThemeMode> toggleThemeMode() async {
    final currentResult = await repository.getCurrentThemeMode();

    return currentResult.fold(
      ResultHelper.failure,
      (currentMode) async {
        final newMode = switch (currentMode) {
          ThemeMode.light => ThemeMode.dark,
          ThemeMode.dark => ThemeMode.light,
          ThemeMode.system =>
            ThemeMode.light, // Default to light when toggling from system
        };

        final setResult = await repository.setThemeMode(newMode);

        return setResult.fold(
          ResultHelper.failure,
          (_) => ResultHelper.success(newMode),
        );
      },
    );
  }

  /// Set to light mode
  FutureResult<void> setLightMode() async {
    return repository.setThemeMode(ThemeMode.light);
  }

  /// Set to dark mode
  FutureResult<void> setDarkMode() async {
    return repository.setThemeMode(ThemeMode.dark);
  }

  /// Set to system mode
  FutureResult<void> setSystemMode() async {
    return repository.setThemeMode(ThemeMode.system);
  }

  /// Check if current mode matches given mode
  FutureResult<bool> isCurrentMode(ThemeMode mode) async {
    final currentResult = await repository.getCurrentThemeMode();

    return currentResult.fold(
      ResultHelper.failure,
      (currentMode) => ResultHelper.success(currentMode == mode),
    );
  }
}
