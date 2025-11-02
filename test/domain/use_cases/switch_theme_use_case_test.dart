import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/entities/theme_entity.dart';
import 'package:flutter_theme_showcase/domain/repositories/theme_repository.dart';
import 'package:flutter_theme_showcase/domain/use_cases/theme/switch_theme_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'switch_theme_use_case_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  group('SwitchThemeUseCase', () {
    late SwitchThemeUseCase useCase;
    late MockThemeRepository mockRepository;
    late ThemeEntity testTheme;

    setUp(() {
      mockRepository = MockThemeRepository();
      useCase = SwitchThemeUseCase(repository: mockRepository);
      testTheme = const ThemeEntity.createDefault().copyWith(id: 'modern');
    });

    group('call()', () {
      test('should switch theme when theme ID is valid and exists', () async {
        // Arrange
        when(mockRepository.themeExists('modern'))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentTheme('modern'))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentTheme())
            .thenAnswer((_) async => ResultHelper.success(testTheme));

        // Act
        final result = await useCase('modern');

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.id, equals('modern'));
        verify(mockRepository.themeExists('modern')).called(1);
        verify(mockRepository.setCurrentTheme('modern')).called(1);
        verify(mockRepository.getCurrentTheme()).called(1);
      });

      test('should return validation failure for empty theme ID', () async {
        // Act
        final result = await useCase('');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<ValidationFailure>());
        verifyNever(mockRepository.themeExists(any));
        verifyNever(mockRepository.setCurrentTheme(any));
      });

      test('should return failure when theme does not exist', () async {
        // Arrange
        when(mockRepository.themeExists('nonexistent'))
            .thenAnswer((_) async => ResultHelper.success(false));

        // Act
        final result = await useCase('nonexistent');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<ThemeFailure>());
        expect((result.failureValue as ThemeFailure).code, equals('THEME_NOT_FOUND'));
        verify(mockRepository.themeExists('nonexistent')).called(1);
        verifyNever(mockRepository.setCurrentTheme(any));
      });

      test('should return failure when themeExists check fails', () async {
        // Arrange
        const failure = ThemeFailure(message: 'Failed to check theme');
        when(mockRepository.themeExists('modern'))
            .thenAnswer((_) async => ResultHelper.failure<bool>(failure));

        // Act
        final result = await useCase('modern');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.themeExists('modern')).called(1);
        verifyNever(mockRepository.setCurrentTheme(any));
      });

      test('should return failure when setCurrentTheme fails', () async {
        // Arrange
        const failure = ThemeFailure(message: 'Failed to set theme');
        when(mockRepository.themeExists('modern'))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentTheme('modern'))
            .thenAnswer((_) async => ResultHelper.failure<void>(failure));

        // Act
        final result = await useCase('modern');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.themeExists('modern')).called(1);
        verify(mockRepository.setCurrentTheme('modern')).called(1);
        verifyNever(mockRepository.getCurrentTheme());
      });

      test('should call methods in correct order', () async {
        // Arrange
        when(mockRepository.themeExists('modern'))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentTheme('modern'))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentTheme())
            .thenAnswer((_) async => ResultHelper.success(testTheme));

        // Act
        await useCase('modern');

        // Assert
        verifyInOrder([
          mockRepository.themeExists('modern'),
          mockRepository.setCurrentTheme('modern'),
          mockRepository.getCurrentTheme(),
        ]);
      });
    });

    group('switchToDefault()', () {
      test('should switch to default theme', () async {
        // Arrange
        final defaultTheme = const ThemeEntity.createDefault();
        when(mockRepository.themeExists('default'))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentTheme('default'))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentTheme())
            .thenAnswer((_) async => ResultHelper.success(defaultTheme));

        // Act
        final result = await useCase.switchToDefault();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.id, equals('default'));
        verify(mockRepository.themeExists('default')).called(1);
        verify(mockRepository.setCurrentTheme('default')).called(1);
      });
    });

    group('switchToPrevious()', () {
      test('should switch to default theme (fallback implementation)', () async {
        // Arrange
        final defaultTheme = const ThemeEntity.createDefault();
        when(mockRepository.themeExists('default'))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentTheme('default'))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentTheme())
            .thenAnswer((_) async => ResultHelper.success(defaultTheme));

        // Act
        final result = await useCase.switchToPrevious();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.id, equals('default'));
        verify(mockRepository.themeExists('default')).called(1);
      });
    });
  });
}
