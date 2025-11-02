import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/repositories/theme_repository.dart';
import 'package:flutter_theme_showcase/domain/use_cases/theme/manage_theme_mode_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'manage_theme_mode_use_case_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  group('ManageThemeModeUseCase', () {
    late ManageThemeModeUseCase useCase;
    late MockThemeRepository mockRepository;

    setUp(() {
      mockRepository = MockThemeRepository();
      useCase = ManageThemeModeUseCase(repository: mockRepository);
    });

    group('getCurrentThemeMode()', () {
      test('should return current theme mode when repository call succeeds',
          () async {
        // Arrange
        when(mockRepository.getCurrentThemeMode())
            .thenAnswer((_) async => ResultHelper.success(ThemeMode.dark));

        // Act
        final result = await useCase.getCurrentThemeMode();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(ThemeMode.dark));
        verify(mockRepository.getCurrentThemeMode()).called(1);
      });

      test('should return failure when repository call fails', () async {
        // Arrange
        const failure = ThemeFailure(message: 'Failed to get theme mode');
        when(mockRepository.getCurrentThemeMode())
            .thenAnswer((_) async => ResultHelper.failure<ThemeMode>(failure));

        // Act
        final result = await useCase.getCurrentThemeMode();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.getCurrentThemeMode()).called(1);
      });
    });

    group('setThemeMode()', () {
      test('should set theme mode successfully', () async {
        // Arrange
        when(mockRepository.setThemeMode(ThemeMode.light))
            .thenAnswer((_) async => ResultHelper.success<void>(null));

        // Act
        final result = await useCase.setThemeMode(ThemeMode.light);

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockRepository.setThemeMode(ThemeMode.light)).called(1);
      });

      test('should return failure when repository call fails', () async {
        // Arrange
        const failure = ThemeFailure(message: 'Failed to set theme mode');
        when(mockRepository.setThemeMode(ThemeMode.dark))
            .thenAnswer((_) async => ResultHelper.failure<void>(failure));

        // Act
        final result = await useCase.setThemeMode(ThemeMode.dark);

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.setThemeMode(ThemeMode.dark)).called(1);
      });
    });

    group('toggleThemeMode()', () {
      test('should toggle from light to dark mode', () async {
        // Arrange
        when(mockRepository.getCurrentThemeMode())
            .thenAnswer((_) async => ResultHelper.success(ThemeMode.light));
        when(mockRepository.setThemeMode(ThemeMode.dark))
            .thenAnswer((_) async => ResultHelper.success<void>(null));

        // Act
        final result = await useCase.toggleThemeMode();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(ThemeMode.dark));
        verify(mockRepository.getCurrentThemeMode()).called(1);
        verify(mockRepository.setThemeMode(ThemeMode.dark)).called(1);
      });

      test('should toggle from dark to light mode', () async {
        // Arrange
        when(mockRepository.getCurrentThemeMode())
            .thenAnswer((_) async => ResultHelper.success(ThemeMode.dark));
        when(mockRepository.setThemeMode(ThemeMode.light))
            .thenAnswer((_) async => ResultHelper.success<void>(null));

        // Act
        final result = await useCase.toggleThemeMode();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(ThemeMode.light));
        verify(mockRepository.getCurrentThemeMode()).called(1);
        verify(mockRepository.setThemeMode(ThemeMode.light)).called(1);
      });

      test('should default to light when toggling from system mode', () async {
        // Arrange
        when(mockRepository.getCurrentThemeMode())
            .thenAnswer((_) async => ResultHelper.success(ThemeMode.system));
        when(mockRepository.setThemeMode(ThemeMode.light))
            .thenAnswer((_) async => ResultHelper.success<void>(null));

        // Act
        final result = await useCase.toggleThemeMode();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(ThemeMode.light));
        verify(mockRepository.getCurrentThemeMode()).called(1);
        verify(mockRepository.setThemeMode(ThemeMode.light)).called(1);
      });

      test('should return failure when getCurrentThemeMode fails', () async {
        // Arrange
        const failure = ThemeFailure(message: 'Failed to get theme mode');
        when(mockRepository.getCurrentThemeMode())
            .thenAnswer((_) async => ResultHelper.failure<ThemeMode>(failure));

        // Act
        final result = await useCase.toggleThemeMode();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.getCurrentThemeMode()).called(1);
        verifyNever(mockRepository.setThemeMode(any));
      });

      test('should return failure when setThemeMode fails', () async {
        // Arrange
        const failure = ThemeFailure(message: 'Failed to set theme mode');
        when(mockRepository.getCurrentThemeMode())
            .thenAnswer((_) async => ResultHelper.success(ThemeMode.light));
        when(mockRepository.setThemeMode(ThemeMode.dark))
            .thenAnswer((_) async => ResultHelper.failure<void>(failure));

        // Act
        final result = await useCase.toggleThemeMode();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.getCurrentThemeMode()).called(1);
        verify(mockRepository.setThemeMode(ThemeMode.dark)).called(1);
      });
    });

    group('setLightMode()', () {
      test('should set light mode successfully', () async {
        // Arrange
        when(mockRepository.setThemeMode(ThemeMode.light))
            .thenAnswer((_) async => ResultHelper.success<void>(null));

        // Act
        final result = await useCase.setLightMode();

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockRepository.setThemeMode(ThemeMode.light)).called(1);
      });
    });

    group('setDarkMode()', () {
      test('should set dark mode successfully', () async {
        // Arrange
        when(mockRepository.setThemeMode(ThemeMode.dark))
            .thenAnswer((_) async => ResultHelper.success<void>(null));

        // Act
        final result = await useCase.setDarkMode();

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockRepository.setThemeMode(ThemeMode.dark)).called(1);
      });
    });

    group('setSystemMode()', () {
      test('should set system mode successfully', () async {
        // Arrange
        when(mockRepository.setThemeMode(ThemeMode.system))
            .thenAnswer((_) async => ResultHelper.success<void>(null));

        // Act
        final result = await useCase.setSystemMode();

        // Assert
        expect(result.isSuccess, isTrue);
        verify(mockRepository.setThemeMode(ThemeMode.system)).called(1);
      });
    });
  });
}
