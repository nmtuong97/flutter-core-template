import 'package:flutter/material.dart';

import '../../core/errors/error_handler.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/result.dart';
import '../../core/utilities/constants.dart';
import '../../core/utilities/logger.dart';
import '../../domain/entities/localization_entity.dart';
import '../../domain/repositories/localization_repository.dart';
import '../sources/local/local_data_source.dart';

/// Implementation of LocalizationRepository
class LocalizationRepositoryImpl implements LocalizationRepository {
  const LocalizationRepositoryImpl({
    required this.localDataSource,
  });

  final LocalDataSource localDataSource;

  @override
  FutureResult<LocalizationEntity> getCurrentLocalization() async {
    try {
      AppLogger.localization('Getting current localization');

      // Load current locale from preferences
      final localeString =
          await localDataSource.loadString(AppConstants.localeKey);
      final currentLocaleString = localeString ?? AppConstants.defaultLocale;

      // Parse locale and find matching localization
      final locale = _parseLocale(currentLocaleString);
      return await getLocalizationByLocale(locale);
    } on Exception catch (e) {
      AppLogger.error('Failed to get current localization', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<List<LocalizationEntity>> getSupportedLocalizations() async {
    try {
      AppLogger.localization('Getting supported localizations');

      // Return hardcoded supported localizations
      final localizations = _getSupportedLocalizations();

      AppLogger.localization(
        'Found ${localizations.length} supported localizations',
      );
      return ResultHelper.success(localizations);
    } on Exception catch (e) {
      AppLogger.error('Failed to get supported localizations', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> setCurrentLocalization(Locale locale) async {
    try {
      AppLogger.localization('Setting current localization: $locale');

      // Verify locale is supported
      final isSupported = await isLocaleSupported(locale);
      return await isSupported.fold(
        ResultHelper.failure,
        (supported) async {
          if (!supported) {
            return ResultHelper.failure(
              LocalizationFailure(
                message: 'Locale not supported: $locale',
                code: 'LOCALE_NOT_SUPPORTED',
              ),
            );
          }

          await localDataSource.saveString(
            AppConstants.localeKey,
            locale.toString(),
          );
          AppLogger.localization('Current localization set successfully');
          return ResultHelper.success(null);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Failed to set current localization', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<LocalizationEntity> getLocalizationByLocale(
    Locale locale,
  ) async {
    try {
      AppLogger.localization('Getting localization by locale: $locale');

      final localizations = _getSupportedLocalizations();
      final localization =
          localizations.where((l) => l.locale == locale).firstOrNull;

      if (localization == null) {
        // Try to find by language code only
        final fallbackLocalization = localizations
            .where((l) => l.languageCode == locale.languageCode)
            .firstOrNull;

        if (fallbackLocalization == null) {
          return ResultHelper.failure(
            LocalizationFailure(
              message: 'Localization not found: $locale',
              code: 'LOCALIZATION_NOT_FOUND',
            ),
          );
        }

        return ResultHelper.success(fallbackLocalization);
      }

      return ResultHelper.success(localization);
    } on Exception catch (e) {
      AppLogger.error('Failed to get localization by locale', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<bool> isLocaleSupported(Locale locale) async {
    try {
      final localizations = await getSupportedLocalizations();
      return localizations.fold(
        ResultHelper.failure,
        (localizationList) {
          final isSupported = localizationList.any(
            (l) => l.locale == locale || l.languageCode == locale.languageCode,
          );
          return ResultHelper.success(isSupported);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Failed to check locale support', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<Locale> getSystemLocale() async {
    try {
      AppLogger.localization('Getting system locale');

      // Get system locale - this would typically use platform channels
      // For now, return default locale
      const systemLocale = Locale('en');

      AppLogger.localization('System locale: $systemLocale');
      return ResultHelper.success(systemLocale);
    } on Exception catch (e) {
      AppLogger.error('Failed to get system locale', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> resetToDefaultLocale() async {
    try {
      AppLogger.localization('Resetting to default locale');

      await localDataSource.saveString(
        AppConstants.localeKey,
        AppConstants.defaultLocale,
      );

      AppLogger.localization('Reset to default locale successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to reset to default locale', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<Locale?> getSavedLocale() async {
    try {
      AppLogger.localization('Getting saved locale');

      final localeString =
          await localDataSource.loadString(AppConstants.localeKey);

      if (localeString == null) {
        return ResultHelper.success(null);
      }

      final locale = _parseLocale(localeString);
      AppLogger.localization('Saved locale: $locale');
      return ResultHelper.success(locale);
    } on Exception catch (e) {
      AppLogger.error('Failed to get saved locale', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> saveLocalePreference(Locale locale) async {
    try {
      AppLogger.localization('Saving locale preference: $locale');

      await localDataSource.saveString(
        AppConstants.localeKey,
        locale.toString(),
      );

      AppLogger.localization('Locale preference saved successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to save locale preference', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  @override
  FutureResult<void> clearLocalePreference() async {
    try {
      AppLogger.localization('Clearing locale preference');

      await localDataSource.removeValue(AppConstants.localeKey);

      AppLogger.localization('Locale preference cleared successfully');
      return ResultHelper.success(null);
    } on Exception catch (e) {
      AppLogger.error('Failed to clear locale preference', error: e);
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }

  /// Get supported localizations
  List<LocalizationEntity> _getSupportedLocalizations() {
    return [
      const LocalizationEntity.english(),
      const LocalizationEntity.vietnamese(),
    ];
  }

  /// Parse locale string to Locale object
  Locale _parseLocale(String localeString) {
    final parts = localeString.split('_');
    if (parts.length == 1) {
      return Locale(parts[0]);
    } else if (parts.length >= 2) {
      return Locale(parts[0], parts[1]);
    } else {
      return const Locale('en'); // Fallback
    }
  }
}
