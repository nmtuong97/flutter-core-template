import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/entities/localization_entity.dart';
import 'package:flutter_theme_showcase/domain/repositories/localization_repository.dart';
import 'package:flutter_theme_showcase/domain/use_cases/localization/get_current_localization_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_current_localization_use_case_test.mocks.dart';

@GenerateMocks([LocalizationRepository])
void main() {
  group('GetCurrentLocalizationUseCase', () {
    late GetCurrentLocalizationUseCase useCase;
    late MockLocalizationRepository mockRepository;
    late LocalizationEntity testLocalization;

    setUp(() {
      mockRepository = MockLocalizationRepository();
      useCase = GetCurrentLocalizationUseCase(repository: mockRepository);
      testLocalization = const LocalizationEntity.vietnamese();
    });

    test('should return current localization when repository call succeeds',
        () async {
      // Arrange
      when(mockRepository.getCurrentLocalization())
          .thenAnswer((_) async => ResultHelper.success(testLocalization));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.successValue, equals(testLocalization));
      expect(result.successValue?.locale, equals(const Locale('vi')));
      verify(mockRepository.getCurrentLocalization()).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const failure = LocalizationFailure(
        message: 'Failed to get current localization',
      );
      when(mockRepository.getCurrentLocalization())
          .thenAnswer((_) async => ResultHelper.failure<LocalizationEntity>(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isFailure, isTrue);
      expect(result.failureValue, equals(failure));
      verify(mockRepository.getCurrentLocalization()).called(1);
    });

    test('should call repository only once', () async {
      // Arrange
      when(mockRepository.getCurrentLocalization())
          .thenAnswer((_) async => ResultHelper.success(testLocalization));

      // Act
      await useCase();

      // Assert
      verify(mockRepository.getCurrentLocalization()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
