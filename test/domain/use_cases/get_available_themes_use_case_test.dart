import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/entities/theme_entity.dart';
import 'package:flutter_theme_showcase/domain/repositories/theme_repository.dart';
import 'package:flutter_theme_showcase/domain/use_cases/theme/get_available_themes_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_available_themes_use_case_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  group('GetAvailableThemesUseCase', () {
    late GetAvailableThemesUseCase useCase;
    late MockThemeRepository mockRepository;
    late List<ThemeEntity> testThemes;

    setUp(() {
      mockRepository = MockThemeRepository();
      useCase = GetAvailableThemesUseCase(repository: mockRepository);
      
      // Create test themes using createDefault factory and copyWith
      final defaultTheme = const ThemeEntity.createDefault();
      testThemes = [
        defaultTheme.copyWith(
          id: 'default',
          name: 'Default Theme',
          tags: ['material', 'default'],
        ),
        defaultTheme.copyWith(
          id: 'custom1',
          name: 'Custom Theme 1',
          description: 'Custom theme',
          isDefault: false,
          isCustom: true,
          tags: ['custom', 'light'],
        ),
        defaultTheme.copyWith(
          id: 'dark',
          name: 'Dark Theme',
          description: 'Dark theme',
          isDefault: false,
          tags: ['dark', 'modern'],
        ),
      ];
    });

    group('call()', () {
      test('should return all available themes when repository call succeeds',
          () async {
        // Arrange
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.success(testThemes));

        // Act
        final result = await useCase();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, equals(testThemes));
        expect(result.successValue?.length, equals(3));
        verify(mockRepository.getAvailableThemes()).called(1);
      });

      test('should return failure when repository call fails', () async {
        // Arrange
        const failure = ThemeFailure(
          message: 'Failed to get available themes',
        );
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.failure<List<ThemeEntity>>(failure));

        // Act
        final result = await useCase();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.getAvailableThemes()).called(1);
      });

      test('should call repository only once', () async {
        // Arrange
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.success(testThemes));

        // Act
        await useCase();

        // Assert
        verify(mockRepository.getAvailableThemes()).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should return empty list when no themes available', () async {
        // Arrange
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.success<List<ThemeEntity>>([]));

        // Act
        final result = await useCase();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isEmpty);
        verify(mockRepository.getAvailableThemes()).called(1);
      });
    });

    group('getThemesByTags()', () {
      test('should return themes matching specified tags', () async {
        // Arrange
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.success(testThemes));

        // Act
        final result = await useCase.getThemesByTags(['dark']);

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.length, equals(1));
        expect(result.successValue?.first.id, equals('dark'));
        verify(mockRepository.getAvailableThemes()).called(1);
      });

      test('should return themes matching any of multiple tags', () async {
        // Arrange
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.success(testThemes));

        // Act
        final result = await useCase.getThemesByTags(['custom', 'default']);

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.length, equals(2));
        verify(mockRepository.getAvailableThemes()).called(1);
      });

      test('should return empty list when no themes match tags', () async {
        // Arrange
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.success(testThemes));

        // Act
        final result = await useCase.getThemesByTags(['nonexistent']);

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isEmpty);
        verify(mockRepository.getAvailableThemes()).called(1);
      });

      test('should return failure when repository call fails', () async {
        // Arrange
        const failure = ThemeFailure(message: 'Failed to get themes');
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.failure<List<ThemeEntity>>(failure));

        // Act
        final result = await useCase.getThemesByTags(['dark']);

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.getAvailableThemes()).called(1);
      });
    });

    group('getCustomThemes()', () {
      test('should return only custom themes', () async {
        // Arrange
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.success(testThemes));

        // Act
        final result = await useCase.getCustomThemes();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.length, equals(1));
        expect(result.successValue?.first.id, equals('custom1'));
        expect(result.successValue?.first.isCustom, isTrue);
        verify(mockRepository.getAvailableThemes()).called(1);
      });

      test('should return empty list when no custom themes exist', () async {
        // Arrange
        final nonCustomThemes = [testThemes[0], testThemes[2]]; // No custom
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.success(nonCustomThemes));

        // Act
        final result = await useCase.getCustomThemes();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue, isEmpty);
        verify(mockRepository.getAvailableThemes()).called(1);
      });

      test('should return failure when repository call fails', () async {
        // Arrange
        const failure = ThemeFailure(message: 'Failed to get custom themes');
        when(mockRepository.getAvailableThemes())
            .thenAnswer((_) async => ResultHelper.failure<List<ThemeEntity>>(failure));

        // Act
        final result = await useCase.getCustomThemes();

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.getAvailableThemes()).called(1);
      });
    });
  });
}
