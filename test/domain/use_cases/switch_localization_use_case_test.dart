import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/entities/localization_entity.dart';
import 'package:flutter_theme_showcase/domain/repositories/localization_repository.dart';
import 'package:flutter_theme_showcase/domain/use_cases/localization/switch_localization_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'switch_localization_use_case_test.mocks.dart';

@GenerateMocks([LocalizationRepository])
void main() {
  group('SwitchLocalizationUseCase', () {
    late SwitchLocalizationUseCase useCase;
    late MockLocalizationRepository mockRepository;
    late LocalizationEntity testLocalization;

    setUp(() {
      mockRepository = MockLocalizationRepository();
      useCase = SwitchLocalizationUseCase(repository: mockRepository);
      testLocalization = const LocalizationEntity.vietnamese();
    });

    group('call() with string', () {
      test('should switch localization when locale string is valid', () async {
        // Arrange
        when(mockRepository.isLocaleSupported(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentLocalization(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentLocalization())
            .thenAnswer((_) async => ResultHelper.success(testLocalization));

        // Act
        final result = await useCase('vi');

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale, equals(const Locale('vi')));
        verify(mockRepository.isLocaleSupported(const Locale('vi'))).called(1);
        verify(mockRepository.setCurrentLocalization(const Locale('vi'))).called(1);
        verify(mockRepository.getCurrentLocalization()).called(1);
      });

      test('should return validation failure for empty locale string', () async {
        // Act
        final result = await useCase('');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<ValidationFailure>());
        verifyNever(mockRepository.isLocaleSupported(any));
        verifyNever(mockRepository.setCurrentLocalization(any));
      });

      test('should return failure when locale is not supported', () async {
        // Arrange
        when(mockRepository.isLocaleSupported(const Locale('fr')))
            .thenAnswer((_) async => ResultHelper.success(false));

        // Act
        final result = await useCase('fr');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, isA<LocalizationFailure>());
        verify(mockRepository.isLocaleSupported(const Locale('fr'))).called(1);
        verifyNever(mockRepository.setCurrentLocalization(any));
      });

      test('should return failure when isLocaleSupported check fails', () async {
        // Arrange
        const failure = LocalizationFailure(message: 'Failed to check locale');
        when(mockRepository.isLocaleSupported(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.failure<bool>(failure));

        // Act
        final result = await useCase('vi');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.isLocaleSupported(const Locale('vi'))).called(1);
        verifyNever(mockRepository.setCurrentLocalization(any));
      });

      test('should return failure when setCurrentLocalization fails', () async {
        // Arrange
        const failure = LocalizationFailure(message: 'Failed to set localization');
        when(mockRepository.isLocaleSupported(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentLocalization(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.failure<void>(failure));

        // Act
        final result = await useCase('vi');

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.failureValue, equals(failure));
        verify(mockRepository.isLocaleSupported(const Locale('vi'))).called(1);
        verify(mockRepository.setCurrentLocalization(const Locale('vi'))).called(1);
        verifyNever(mockRepository.getCurrentLocalization());
      });
    });

    group('callWithLocale() with Locale object', () {
      test('should switch localization when Locale object is valid', () async {
        // Arrange
        when(mockRepository.isLocaleSupported(const Locale('en')))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentLocalization(const Locale('en')))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentLocalization())
            .thenAnswer((_) async => ResultHelper.success(const LocalizationEntity.english()));

        // Act
        final result = await useCase.callWithLocale(const Locale('en'));

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale, equals(const Locale('en')));
        verify(mockRepository.isLocaleSupported(const Locale('en'))).called(1);
        verify(mockRepository.setCurrentLocalization(const Locale('en'))).called(1);
      });

      test('should call methods in correct order', () async {
        // Arrange
        when(mockRepository.isLocaleSupported(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentLocalization(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentLocalization())
            .thenAnswer((_) async => ResultHelper.success(testLocalization));

        // Act
        await useCase.callWithLocale(const Locale('vi'));

        // Assert
        verifyInOrder([
          mockRepository.isLocaleSupported(const Locale('vi')),
          mockRepository.setCurrentLocalization(const Locale('vi')),
          mockRepository.getCurrentLocalization(),
        ]);
      });
    });

    group('switchToEnglish()', () {
      test('should switch to English locale', () async {
        // Arrange
        when(mockRepository.isLocaleSupported(const Locale('en')))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentLocalization(const Locale('en')))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentLocalization())
            .thenAnswer((_) async => ResultHelper.success(const LocalizationEntity.english()));

        // Act
        final result = await useCase.switchToEnglish();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale, equals(const Locale('en')));
        verify(mockRepository.isLocaleSupported(const Locale('en'))).called(1);
      });
    });

    group('switchToVietnamese()', () {
      test('should switch to Vietnamese locale', () async {
        // Arrange
        when(mockRepository.isLocaleSupported(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.success(true));
        when(mockRepository.setCurrentLocalization(const Locale('vi')))
            .thenAnswer((_) async => ResultHelper.success<void>(null));
        when(mockRepository.getCurrentLocalization())
            .thenAnswer((_) async => ResultHelper.success(testLocalization));

        // Act
        final result = await useCase.switchToVietnamese();

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.successValue?.locale, equals(const Locale('vi')));
        verify(mockRepository.isLocaleSupported(const Locale('vi'))).called(1);
      });
    });
  });
}
