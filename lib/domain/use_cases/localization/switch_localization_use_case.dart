import 'package:flutter/material.dart';

import '../../../core/errors/failures.dart';
import '../../../core/errors/result.dart';
import '../../../core/utilities/validators.dart';
import '../../entities/localization_entity.dart';
import '../../repositories/localization_repository.dart';

/// Use case for switching to a different localization
class SwitchLocalizationUseCase {
  const SwitchLocalizationUseCase({
    required this.repository,
  });

  final LocalizationRepository repository;

  /// Execute the use case with locale string
  FutureResult<LocalizationEntity> call(String localeString) async {
    // Validate locale format
    final validationError = Validators.getLocaleError(localeString);
    if (validationError != null) {
      return ResultHelper.failure(
        ValidationFailure(message: validationError),
      );
    }

    // Parse locale string to Locale object
    final locale = _parseLocale(localeString);

    return callWithLocale(locale);
  }

  /// Execute the use case with Locale object
  FutureResult<LocalizationEntity> callWithLocale(Locale locale) async {
    // Check if locale is supported
    final supportedResult = await repository.isLocaleSupported(locale);

    return supportedResult.fold(
      ResultHelper.failure,
      (isSupported) async {
        if (!isSupported) {
          return ResultHelper.failure(
            const LocalizationFailure(
              message: 'Locale not supported',
              code: 'LOCALE_NOT_SUPPORTED',
            ),
          );
        }

        // Set the current localization
        final setResult = await repository.setCurrentLocalization(locale);

        return setResult.fold(
          ResultHelper.failure,
          (_) async {
            // Return the newly set localization
            return repository.getCurrentLocalization();
          },
        );
      },
    );
  }

  /// Switch to English
  FutureResult<LocalizationEntity> switchToEnglish() async {
    return call('en');
  }

  /// Switch to Vietnamese
  FutureResult<LocalizationEntity> switchToVietnamese() async {
    return call('vi');
  }

  /// Switch to system locale
  FutureResult<LocalizationEntity> switchToSystemLocale() async {
    final systemLocaleResult = await repository.getSystemLocale();

    return systemLocaleResult.fold(
      ResultHelper.failure,
      (systemLocale) async {
        return callWithLocale(systemLocale);
      },
    );
  }

  /// Reset to default locale
  FutureResult<LocalizationEntity> resetToDefault() async {
    final resetResult = await repository.resetToDefaultLocale();

    return resetResult.fold(
      ResultHelper.failure,
      (_) async {
        return repository.getCurrentLocalization();
      },
    );
  }

  /// Parse locale string to Locale object
  Locale _parseLocale(String localeString) {
    final parts = localeString.split('_');
    if (parts.length == 1) {
      return Locale(parts[0]);
    } else if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(parts[0]);
    }
  }
}
