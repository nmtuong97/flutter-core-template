import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/core/utilities/constants.dart';
import 'package:flutter_theme_showcase/data/repositories/localization_repository_impl.dart';
import 'package:flutter_theme_showcase/data/sources/local/local_data_source.dart';
import 'package:flutter_theme_showcase/domain/entities/localization_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'localization_repository_impl_test.mocks.dart';

@GenerateMocks([LocalDataSource])
void main() {
  group('LocalizationRepositoryImpl', () {
    late LocalizationRepositoryImpl repository;
    late MockLocalDataSource mockLocalDataSource;

    setUp(() {
      mockLocalDataSource = MockLocalDataSource();
      repository = LocalizationRepositoryImpl(localDataSource: mockLocalDataSource);
    });

    group('getCurrentLocalization()', () {
      test('should return default localization when no locale is stored', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.localeKey))
            .thenAnswer((_) async => null);

        // Act
        final result = await repository.getCurrentLocalization();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale.toString(), equals(AppConstants.defaultLocale));
        verify(mockLocalDataSource.loadString(AppConstants.localeKey)).called(1);
      });

      test('should return English localization when "en" is stored', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.localeKey))
            .thenAnswer((_) async => 'en');

        // Act
        final result = await repository.getCurrentLocalization();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale, equals(const Locale('en')));
        expect(result.successValue?.languageName, equals('English'));
      });

      test('should return Vietnamese localization when "vi" is stored', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.localeKey))
            .thenAnswer((_) async => 'vi');

        // Act
        final result = await repository.getCurrentLocalization();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale, equals(const Locale('vi')));
        expect(result.successValue?.languageName, equals('Tiếng Việt'));
      });

      test('should return failure when locale is not supported', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.localeKey))
            .thenAnswer((_) async => 'fr');

        // Act
        final result = await repository.getCurrentLocalization();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<LocalizationFailure>());
      });

      test('should return failure when data source throws exception', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.localeKey))
            .thenThrow(Exception('Data source error'));

        // Act
        final result = await repository.getCurrentLocalization();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<Failure>());
      });
    });

    group('getSupportedLocalizations()', () {
      test('should return list of supported localizations', () async {
        // Act
        final result = await repository.getSupportedLocalizations();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isNotEmpty);
        expect(result.successValue?.length, equals(2)); // English and Vietnamese
      });

      test('should include English and Vietnamese', () async {
        // Act
        final result = await repository.getSupportedLocalizations();

        // Assert
        expect(result.isSuccess, isTrue);
        final localizations = result.successValue!;
        expect(localizations.any((l) => l.locale == const Locale('en')), isTrue);
        expect(localizations.any((l) => l.locale == const Locale('vi')), isTrue);
      });

      test('should return localizations with required properties', () async {
        // Act
        final result = await repository.getSupportedLocalizations();

        // Assert
        expect(result.isSuccess, isTrue);
        for (final localization in result.successValue!) {
          expect(localization.locale, isNotNull);
          expect(localization.languageName, isNotEmpty);
          expect(localization.countryName, isNotNull);
        }
      });

      test('should mark one localization as default', () async {
        // Act
        final result = await repository.getSupportedLocalizations();

        // Assert
        expect(result.isSuccess, isTrue);
        final defaultLocalization = result.successValue!.where((l) => l.isDefault).toList();
        expect(defaultLocalization.length, equals(1));
      });
    });

    group('setCurrentLocalization()', () {
      test('should save English locale successfully', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.localeKey, 'en'))
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.setCurrentLocalization(const Locale('en'));

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockLocalDataSource.saveString(AppConstants.localeKey, 'en')).called(1);
      });

      test('should save Vietnamese locale successfully', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.localeKey, 'vi'))
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.setCurrentLocalization(const Locale('vi'));

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockLocalDataSource.saveString(AppConstants.localeKey, 'vi')).called(1);
      });

      test('should return failure when locale is not supported', () async {
        // Act
        final result = await repository.setCurrentLocalization(const Locale('fr'));

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<LocalizationFailure>());
        expect(
          (result.failureValue as LocalizationFailure).code,
          equals('LOCALE_NOT_SUPPORTED'),
        );
        verifyNever(mockLocalDataSource.saveString(any, any));
      });

      test('should return failure when data source fails', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.localeKey, 'en'))
            .thenThrow(Exception('Save failed'));

        // Act
        final result = await repository.setCurrentLocalization(const Locale('en'));

        // Assert
        expect(result.isFailure, isTrue);
      });
    });

    group('getLocalizationByLocale()', () {
      test('should return English localization', () async {
        // Act
        final result = await repository.getLocalizationByLocale(const Locale('en'));

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale, equals(const Locale('en')));
        expect(result.successValue?.languageName, equals('English'));
      });

      test('should return Vietnamese localization', () async {
        // Act
        final result = await repository.getLocalizationByLocale(const Locale('vi'));

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale, equals(const Locale('vi')));
        expect(result.successValue?.languageName, equals('Tiếng Việt'));
      });

      test('should return failure when locale is not supported', () async {
        // Act
        final result = await repository.getLocalizationByLocale(const Locale('fr'));

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<LocalizationFailure>());
      });

      test('should return different localizations for different locales', () async {
        // Act
        final result1 = await repository.getLocalizationByLocale(const Locale('en'));
        final result2 = await repository.getLocalizationByLocale(const Locale('vi'));

        // Assert
        expect(result1.isSuccess, isTrue);
        expect(result2.isSuccess, isTrue);
        expect(result1.successValue?.locale, isNot(equals(result2.successValue?.locale)));
      });
    });

    group('isLocaleSupported()', () {
      test('should return true for English locale', () async {
        // Act
        final result = await repository.isLocaleSupported(const Locale('en'));

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isTrue);
      });

      test('should return true for Vietnamese locale', () async {
        // Act
        final result = await repository.isLocaleSupported(const Locale('vi'));

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isTrue);
      });

      test('should return false for unsupported locale', () async {
        // Act
        final result = await repository.isLocaleSupported(const Locale('fr'));

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isFalse);
      });

      test('should return false for invalid locale', () async {
        // Act
        final result = await repository.isLocaleSupported(const Locale('invalid'));

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isFalse);
      });
    });
  });
}
