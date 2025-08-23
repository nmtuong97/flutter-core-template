import 'package:flutter/material.dart';

import '../../core/errors/error_handler.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/result.dart';
import '../../core/utilities/constants.dart';
import '../../core/utilities/logger.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/factories/theme_factory.dart';
import '../../domain/repositories/theme_repository.dart';
import '../models/preferences_model.dart';
import '../models/theme_model.dart';
import '../sources/local/local_data_source.dart';

/// Implementation of ThemeRepository
class ThemeRepositoryImpl implements ThemeRepository {
  const ThemeRepositoryImpl({
    required this.localDataSource,
  });

  final LocalDataSource localDataSource;

  @override
  FutureResult<ThemeEntity> getCurrentTheme() async {
    try {
      AppLogger.theme('Getting current theme');

      // Load current theme ID from preferences
      final themeId = await localDataSource.loadString(AppConstants.themeIdKey);
      final currentThemeId = themeId ?? AppConstants.defaultThemeId;

      return await getThemeById(currentThemeId);
    } on Exception catch (e) {
      AppLogger.error('Failed to get current theme', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<List<ThemeEntity>> getAvailableThemes() async {
    try {
      AppLogger.theme('Getting available themes');

      // For now, return hardcoded themes. In a real app, this could load
      // from assets or network
      final themes = _getBuiltInThemes();

      // Add any custom themes from local storage
      // TODO(custom-themes): Implement custom theme loading logic

      AppLogger.theme('Found ${themes.length} available themes');
      return ResultHelper.success(themes);
    } on Exception catch (e) {
      AppLogger.error('Failed to get available themes', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<ThemeEntity> getThemeById(String themeId) async {
    try {
      AppLogger.theme('Getting theme by ID: $themeId');

      final themes = _getBuiltInThemes();
      final theme = themes.where((t) => t.id == themeId).firstOrNull;

      if (theme == null) {
        return ResultHelper.failure(
          ThemeFailure(
            message: 'Theme not found: $themeId',
            code: 'THEME_NOT_FOUND',
          ),
        );
      }

      return ResultHelper.success(theme);
    } on Exception catch (e) {
      AppLogger.error('Failed to get theme by ID', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> saveTheme(ThemeEntity theme) async {
    try {
      AppLogger.theme('Saving theme: ${theme.id}');

      // Convert to model and save
      final themeModel = ThemeModel.fromEntity(theme);
      final json = themeModel.toJson();

      // Save custom theme to local storage
      await localDataSource.saveString(
        'custom_theme_${theme.id}',
        json.toString(),
      );

      AppLogger.theme('Theme saved successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to save theme', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> deleteTheme(String themeId) async {
    try {
      AppLogger.theme('Deleting theme: $themeId');

      // Only allow deletion of custom themes
      final theme = await getThemeById(themeId);
      return await theme.fold(
        ResultHelper.failure,
        (themeEntity) async {
          if (!themeEntity.isCustom) {
            return ResultHelper.failure(
              const ValidationFailure(
                message: 'Cannot delete built-in themes',
                code: 'CANNOT_DELETE_BUILTIN',
              ),
            );
          }

          await localDataSource.removeValue('custom_theme_$themeId');
          AppLogger.theme('Theme deleted successfully');
          return ResultHelper.success(null);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Failed to delete theme', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> setCurrentTheme(String themeId) async {
    try {
      AppLogger.theme('Setting current theme: $themeId');

      // Verify theme exists
      final themeExists = await this.themeExists(themeId);
      return await themeExists.fold(
        ResultHelper.failure,
        (exists) async {
          if (!exists) {
            return ResultHelper.failure(
              ThemeFailure(
                message: 'Theme not found: $themeId',
                code: 'THEME_NOT_FOUND',
              ),
            );
          }

          await localDataSource.saveString(AppConstants.themeIdKey, themeId);
          AppLogger.theme('Current theme set successfully');
          return ResultHelper.success(null);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Failed to set current theme', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<ThemeMode> getCurrentThemeMode() async {
    try {
      final themeModeString =
          await localDataSource.loadString(AppConstants.themeModeKey);
      final themeMode =
          _parseThemeMode(themeModeString ?? AppConstants.systemThemeMode);

      AppLogger.theme('Current theme mode: $themeMode');
      return ResultHelper.success(themeMode);
    } on Exception catch (e) {
      AppLogger.error('Failed to get current theme mode', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> setThemeMode(ThemeMode themeMode) async {
    try {
      AppLogger.theme('Setting theme mode: $themeMode');

      final themeModeString = _themeModeToString(themeMode);
      await localDataSource.saveString(
        AppConstants.themeModeKey,
        themeModeString,
      );

      AppLogger.theme('Theme mode set successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to set theme mode', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<double> getCurrentFontSize() async {
    try {
      final fontSize =
          await localDataSource.loadDouble(AppConstants.fontSizeKey);
      final currentFontSize = fontSize ?? AppConstants.defaultFontSize;

      AppLogger.theme('Current font size: $currentFontSize');
      return ResultHelper.success(currentFontSize);
    } on Exception catch (e) {
      AppLogger.error('Failed to get current font size', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> setFontSize(double fontSize) async {
    try {
      AppLogger.theme('Setting font size: $fontSize');

      await localDataSource.saveDouble(AppConstants.fontSizeKey, fontSize);

      AppLogger.theme('Font size set successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to set font size', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<String> getCurrentFontFamily() async {
    try {
      final fontFamily =
          await localDataSource.loadString(AppConstants.fontFamilyKey);
      final currentFontFamily = fontFamily ?? AppConstants.defaultFontFamily;

      AppLogger.theme('Current font family: $currentFontFamily');
      return ResultHelper.success(currentFontFamily);
    } on Exception catch (e) {
      AppLogger.error('Failed to get current font family', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> setFontFamily(String fontFamily) async {
    try {
      AppLogger.theme('Setting font family: $fontFamily');

      await localDataSource.saveString(AppConstants.fontFamilyKey, fontFamily);

      AppLogger.theme('Font family set successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to set font family', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<bool> themeExists(String themeId) async {
    try {
      final themes = await getAvailableThemes();
      return themes.fold(
        ResultHelper.failure,
        (themeList) {
          final exists = themeList.any((theme) => theme.id == themeId);
          return ResultHelper.success(exists);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Failed to check theme existence', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<Map<String, dynamic>> getThemePreferences() async {
    try {
      AppLogger.theme('Getting theme preferences');

      final preferences = await localDataSource.loadPreferences();
      final prefs = preferences ?? PreferencesModel.defaultPreferences();

      return ResultHelper.success(prefs.toJson());
    } on Exception catch (e) {
      AppLogger.error('Failed to get theme preferences', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> saveThemePreferences(
    Map<String, dynamic> preferences,
  ) async {
    try {
      AppLogger.theme('Saving theme preferences');

      final prefsModel = PreferencesModel.fromJson(preferences);
      await localDataSource.savePreferences(prefsModel.touch());

      AppLogger.theme('Theme preferences saved successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to save theme preferences', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> resetToDefault() async {
    try {
      AppLogger.theme('Resetting theme to default');

      await localDataSource.saveString(
        AppConstants.themeIdKey,
        AppConstants.defaultThemeId,
      );
      await localDataSource.saveString(
        AppConstants.themeModeKey,
        AppConstants.systemThemeMode,
      );
      await localDataSource.saveDouble(
        AppConstants.fontSizeKey,
        AppConstants.defaultFontSize,
      );
      await localDataSource.saveString(
        AppConstants.fontFamilyKey,
        AppConstants.defaultFontFamily,
      );

      AppLogger.theme('Theme reset to default successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to reset theme to default', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> cacheTheme(ThemeEntity theme) async {
    try {
      AppLogger.theme('Caching theme: ${theme.id}');

      // Implement theme caching logic
      // For now, just log the operation
      AppLogger.theme('Theme cached successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to cache theme', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> clearCache() async {
    try {
      AppLogger.theme('Clearing theme cache');

      // Implement cache clearing logic
      // For now, just log the operation
      AppLogger.theme('Theme cache cleared successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to clear theme cache', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  /// Get built-in themes
  List<ThemeEntity> _getBuiltInThemes() {
    return DomainThemeFactory.getAllBuiltInThemes();
  }

  /// Parse theme mode from string
  ThemeMode _parseThemeMode(String themeModeString) {
    switch (themeModeString.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Convert theme mode to string
  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
