import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/core/utilities/constants.dart';
import 'package:flutter_theme_showcase/data/repositories/theme_repository_impl.dart';
import 'package:flutter_theme_showcase/data/sources/local/local_data_source.dart';
import 'package:flutter_theme_showcase/domain/entities/theme_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_impl_test.mocks.dart';

@GenerateMocks([LocalDataSource])
void main() {
  group('ThemeRepositoryImpl', () {
    late ThemeRepositoryImpl repository;
    late MockLocalDataSource mockLocalDataSource;

    setUp(() {
      mockLocalDataSource = MockLocalDataSource();
      repository = ThemeRepositoryImpl(localDataSource: mockLocalDataSource);
    });

    group('getCurrentTheme()', () {
      test('should return default theme when no theme ID is stored', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.themeIdKey))
            .thenAnswer((_) async => null);

        // Act
        final result = await repository.getCurrentTheme();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.id, equals(AppConstants.defaultThemeId));
        verify(mockLocalDataSource.loadString(AppConstants.themeIdKey)).called(1);
      });

      test('should return stored theme when theme ID exists', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.themeIdKey))
            .thenAnswer((_) async => 'cyberpunk');

        // Act
        final result = await repository.getCurrentTheme();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.id, equals('cyberpunk'));
        verify(mockLocalDataSource.loadString(AppConstants.themeIdKey)).called(1);
      });

      test('should return failure when theme ID is invalid', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.themeIdKey))
            .thenAnswer((_) async => 'non_existent_theme');

        // Act
        final result = await repository.getCurrentTheme();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<ThemeFailure>());
      });

      test('should return failure when data source throws exception', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.themeIdKey))
            .thenThrow(Exception('Data source error'));

        // Act
        final result = await repository.getCurrentTheme();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<Failure>());
      });
    });

    group('getAvailableThemes()', () {
      test('should return list of available themes', () async {
        // Act
        final result = await repository.getAvailableThemes();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isNotEmpty);
        expect(result.successValue?.every((t) => t is ThemeEntity), isTrue);
      });

      test('should include all built-in themes', () async {
        // Act
        final result = await repository.getAvailableThemes();

        // Assert
        expect(result.isSuccess, isTrue);
        final themes = result.successValue!;
        expect(themes.any((t) => t.id == 'default'), isTrue);
        expect(themes.any((t) => t.id == 'cyberpunk'), isTrue);
        expect(themes.any((t) => t.id == 'glassmorphism'), isTrue);
        expect(themes.any((t) => t.id == 'neumorphism'), isTrue);
      });

      test('should return themes with required properties', () async {
        // Act
        final result = await repository.getAvailableThemes();

        // Assert
        expect(result.isSuccess, isTrue);
        for (final theme in result.successValue!) {
          expect(theme.id, isNotEmpty);
          expect(theme.name, isNotEmpty);
          expect(theme.lightColors, isNotNull);
          expect(theme.darkColors, isNotNull);
          expect(theme.typography, isNotNull);
        }
      });
    });

    group('getThemeById()', () {
      test('should return theme when ID exists', () async {
        // Act
        final result = await repository.getThemeById('cyberpunk');

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.id, equals('cyberpunk'));
        expect(result.successValue?.name, equals('Cyberpunk'));
      });

      test('should return failure when ID does not exist', () async {
        // Act
        final result = await repository.getThemeById('non_existent');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<ThemeFailure>());
        expect(
          (result.failureValue as ThemeFailure).code,
          equals('THEME_NOT_FOUND'),
        );
      });

      test('should return different themes for different IDs', () async {
        // Act
        final result1 = await repository.getThemeById('cyberpunk');
        final result2 = await repository.getThemeById('glassmorphism');

        // Assert
        expect(result1.isSuccess, isTrue);
        expect(result2.isSuccess, isTrue);
        expect(result1.successValue?.id, isNot(equals(result2.successValue?.id)));
      });
    });

    group('setCurrentTheme()', () {
      test('should save theme ID successfully', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.themeIdKey, 'cyberpunk'))
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.setCurrentTheme('cyberpunk');

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockLocalDataSource.saveString(AppConstants.themeIdKey, 'cyberpunk')).called(1);
      });

      test('should return failure when theme ID is empty', () async {
        // Act
        final result = await repository.setCurrentTheme('');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<ThemeFailure>());
        verifyNever(mockLocalDataSource.saveString(any, any));
      });

      test('should return failure when theme does not exist', () async {
        // Act
        final result = await repository.setCurrentTheme('non_existent');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<ThemeFailure>());
        verifyNever(mockLocalDataSource.saveString(any, any));
      });

      test('should return failure when data source fails', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.themeIdKey, 'cyberpunk'))
            .thenThrow(Exception('Save failed'));

        // Act
        final result = await repository.setCurrentTheme('cyberpunk');

        // Assert
        expect(result.isFailure, isTrue);
      });
    });

    group('themeExists()', () {
      test('should return true when theme exists', () async {
        // Act
        final result = await repository.themeExists('cyberpunk');

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isTrue);
      });

      test('should return false when theme does not exist', () async {
        // Act
        final result = await repository.themeExists('non_existent');

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isFalse);
      });

      test('should return true for all built-in theme IDs', () async {
        // Arrange
        final builtInIds = [
          'default',
          'cyberpunk',
          'glassmorphism',
          'neumorphism',
        ];

        // Act & Assert
        for (final id in builtInIds) {
          final result = await repository.themeExists(id);
          expect(result.isSuccess, isTrue);
          expect(result.successValue, isTrue, reason: 'Theme $id should exist');
        }
      });
    });

    group('getCurrentThemeMode()', () {
      test('should return system mode when no mode is stored', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.themeModeKey))
            .thenAnswer((_) async => null);

        // Act
        final result = await repository.getCurrentThemeMode();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(ThemeMode.system));
      });

      test('should return stored light mode', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.themeModeKey))
            .thenAnswer((_) async => 'light');

        // Act
        final result = await repository.getCurrentThemeMode();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(ThemeMode.light));
      });

      test('should return stored dark mode', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.themeModeKey))
            .thenAnswer((_) async => 'dark');

        // Act
        final result = await repository.getCurrentThemeMode();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(ThemeMode.dark));
      });

      test('should return system mode for invalid stored value', () async {
        // Arrange
        when(mockLocalDataSource.loadString(AppConstants.themeModeKey))
            .thenAnswer((_) async => 'invalid');

        // Act
        final result = await repository.getCurrentThemeMode();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(ThemeMode.system));
      });
    });

    group('setThemeMode()', () {
      test('should save light mode successfully', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.themeModeKey, 'light'))
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.setThemeMode(ThemeMode.light);

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockLocalDataSource.saveString(AppConstants.themeModeKey, 'light')).called(1);
      });

      test('should save dark mode successfully', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.themeModeKey, 'dark'))
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.setThemeMode(ThemeMode.dark);

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockLocalDataSource.saveString(AppConstants.themeModeKey, 'dark')).called(1);
      });

      test('should save system mode successfully', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.themeModeKey, 'system'))
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.setThemeMode(ThemeMode.system);

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockLocalDataSource.saveString(AppConstants.themeModeKey, 'system')).called(1);
      });

      test('should return failure when data source fails', () async {
        // Arrange
        when(mockLocalDataSource.saveString(AppConstants.themeModeKey, 'light'))
            .thenThrow(Exception('Save failed'));

        // Act
        final result = await repository.setThemeMode(ThemeMode.light);

        // Assert
        expect(result.isFailure, isTrue);
      });
    });
  });
}
