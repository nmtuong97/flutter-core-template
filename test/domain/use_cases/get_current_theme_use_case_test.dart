import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/entities/theme_entity.dart';
import 'package:flutter_theme_showcase/domain/repositories/theme_repository.dart';
import 'package:flutter_theme_showcase/domain/use_cases/theme/get_current_theme_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_current_theme_use_case_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  group('GetCurrentThemeUseCase', () {
    late GetCurrentThemeUseCase useCase;
    late MockThemeRepository mockRepository;
    late ThemeEntity testTheme;

    setUp(() {
      mockRepository = MockThemeRepository();
      useCase = GetCurrentThemeUseCase(repository: mockRepository);
      testTheme = const ThemeEntity.createDefault();
    });

    test('should return current theme when repository call is successful',
        () async {
      // Arrange
      when(mockRepository.getCurrentTheme())
          .thenAnswer((_) async => ResultHelper.success(testTheme));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.successValue, equals(testTheme));
      verify(mockRepository.getCurrentTheme()).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const failure = ThemeFailure(
        message: 'Failed to get current theme',
      );
      when(mockRepository.getCurrentTheme())
          .thenAnswer((_) async => ResultHelper.failure(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isFailure, isTrue);
      expect(result.failureValue, equals(failure));
      verify(mockRepository.getCurrentTheme()).called(1);
    });

    test('should call repository only once', () async {
      // Arrange
      when(mockRepository.getCurrentTheme())
          .thenAnswer((_) async => ResultHelper.success(testTheme));

      // Act
      await useCase();

      // Assert
      verify(mockRepository.getCurrentTheme()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
