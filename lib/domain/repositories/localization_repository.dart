import 'package:flutter/material.dart';

import '../../core/errors/result.dart';
import '../entities/localization_entity.dart';

/// Repository interface for localization operations
abstract class LocalizationRepository {
  /// Get the current active locale
  FutureResult<LocalizationEntity> getCurrentLocalization();

  /// Get all supported localizations
  FutureResult<List<LocalizationEntity>> getSupportedLocalizations();

  /// Set the current locale
  FutureResult<void> setCurrentLocalization(Locale locale);

  /// Get localization by locale
  FutureResult<LocalizationEntity> getLocalizationByLocale(Locale locale);

  /// Check if a locale is supported
  FutureResult<bool> isLocaleSupported(Locale locale);

  /// Get system locale
  FutureResult<Locale> getSystemLocale();

  /// Reset to default locale
  FutureResult<void> resetToDefaultLocale();

  /// Get saved locale preference
  FutureResult<Locale?> getSavedLocale();

  /// Save locale preference
  FutureResult<void> saveLocalePreference(Locale locale);

  /// Clear locale preference
  FutureResult<void> clearLocalePreference();
}
