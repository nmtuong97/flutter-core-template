import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/entities/localization_entity.dart';
import 'package:flutter_theme_showcase/domain/repositories/localization_repository.dart';
import 'package:flutter_theme_showcase/domain/use_cases/localization/get_supported_localizations_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_supported_localizations_use_case_test.mocks.dart';

@GenerateMocks([LocalizationRepository])
void main() {
  group('GetSupportedLocalizationsUseCase', () {
    late GetSupportedLocalizationsUseCase useCase;
    late MockLocalizationRepository mockRepository;
    late List<LocalizationEntity> testLocalizations;

    setUp(() {
      mockRepository = MockLocalizationRepository();
      useCase = GetSupportedLocalizationsUseCase(repository: mockRepository);
      testLocalizations = [
        const LocalizationEntity.english(),
        const LocalizationEntity.vietnamese(),
      ];
    });

    test('should return supported localizations when repository call succeeds',
        () async {
      // Arrange
      when(mockRepository.getSupportedLocalizations())
          .thenAnswer((_) async => ResultHelper.success(testLocalizations));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.successValue, equals(testLocalizations));
      expect(result.successValue?.length, equals(2));
      verify(mockRepository.getSupportedLocalizations()).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const failure = LocalizationFailure(
        message: 'Failed to get supported localizations',
      );
      when(mockRepository.getSupportedLocalizations())
          .thenAnswer((_) async => ResultHelper.failure<List<LocalizationEntity>>(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isFailure, isTrue);
      expect(result.failureValue, equals(failure));
      verify(mockRepository.getSupportedLocalizations()).called(1);
    });

    test('should call repository only once', () async {
      // Arrange
      when(mockRepository.getSupportedLocalizations())
          .thenAnswer((_) async => ResultHelper.success(testLocalizations));

      // Act
      await useCase();

      // Assert
      verify(mockRepository.getSupportedLocalizations()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when no localizations available', () async {
      // Arrange
      when(mockRepository.getSupportedLocalizations())
          .thenAnswer((_) async => ResultHelper.success<List<LocalizationEntity>>([]));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.successValue, isEmpty);
      verify(mockRepository.getSupportedLocalizations()).called(1);
    });

    test('should return all supported locales correctly', () async {
      // Arrange
      when(mockRepository.getSupportedLocalizations())
          .thenAnswer((_) async => ResultHelper.success(testLocalizations));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isSuccess, isTrue);
      final locales = result.successValue?.map((l) => l.locale).toList();
      expect(locales, contains(const Locale('en')));
      expect(locales, contains(const Locale('vi')));
      verify(mockRepository.getSupportedLocalizations()).called(1);
    });
  });
}
