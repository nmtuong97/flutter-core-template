import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/entities/localization_entity.dart';
import 'package:flutter_theme_showcase/domain/use_cases/localization/get_current_localization_use_case.dart';
import 'package:flutter_theme_showcase/domain/use_cases/localization/get_supported_localizations_use_case.dart';
import 'package:flutter_theme_showcase/domain/use_cases/localization/switch_localization_use_case.dart';
import 'package:flutter_theme_showcase/presentation/blocs/localization/localization_bloc.dart';
import 'package:flutter_theme_showcase/presentation/blocs/localization/localization_event.dart';
import 'package:flutter_theme_showcase/presentation/blocs/localization/localization_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'localization_bloc_test.mocks.dart';

@GenerateMocks([
  GetCurrentLocalizationUseCase,
  GetSupportedLocalizationsUseCase,
  SwitchLocalizationUseCase,
])
void main() {
  group('LocalizationBloc', () {
    late MockGetCurrentLocalizationUseCase mockGetCurrentUseCase;
    late MockGetSupportedLocalizationsUseCase mockGetSupportedUseCase;
    late MockSwitchLocalizationUseCase mockSwitchUseCase;
    late LocalizationBloc bloc;

    const enLocale = LocalizationEntity.english();
    const viLocale = LocalizationEntity.vietnamese();
    const locales = [enLocale, viLocale];

    setUp(() {
      mockGetCurrentUseCase = MockGetCurrentLocalizationUseCase();
      mockGetSupportedUseCase = MockGetSupportedLocalizationsUseCase();
      mockSwitchUseCase = MockSwitchLocalizationUseCase();

      bloc = LocalizationBloc(
        getCurrentLocalizationUseCase: mockGetCurrentUseCase,
        getSupportedLocalizationsUseCase: mockGetSupportedUseCase,
        switchLocalizationUseCase: mockSwitchUseCase,
      );
    });

    tearDown(() => bloc.close());

    test('initial state is LocalizationInitial', () {
      expect(bloc.state, const LocalizationInitial());
    });

    group('LoadCurrentEvent', () {
      blocTest<LocalizationBloc, LocalizationState>(
        'emits [Loading, Loaded] on success',
        build: () {
          when(mockGetCurrentUseCase())
              .thenAnswer((_) async => ResultHelper.success(enLocale));
          when(mockGetSupportedUseCase())
              .thenAnswer((_) async => ResultHelper.success(locales));
          return bloc;
        },
        act: (b) => b.add(const LocalizationLoadCurrentEvent()),
        expect: () => [
          const LocalizationLoading(),
          isA<LocalizationLoaded>()
              .having((s) => s.currentLocalization, 'current', enLocale)
              .having((s) => s.supportedLocalizations.length, 'count', 2),
        ],
        verify: (_) {
          verify(mockGetCurrentUseCase()).called(1);
          verify(mockGetSupportedUseCase()).called(1);
        },
      );

      blocTest<LocalizationBloc, LocalizationState>(
        'emits [Loading, Error] when getCurrentFails',
        build: () {
          when(mockGetCurrentUseCase()).thenAnswer(
            (_) async => ResultHelper.failure<LocalizationEntity>(
              const LocalizationFailure(message: 'Load failed'),
            ),
          );
          return bloc;
        },
        act: (b) => b.add(const LocalizationLoadCurrentEvent()),
        expect: () => [
          const LocalizationLoading(),
          isA<LocalizationError>().having((s) => s.message, 'msg', 'Load failed'),
        ],
      );
    });

    group('SwitchEvent', () {
      blocTest<LocalizationBloc, LocalizationState>(
        'emits [OperationInProgress, Loaded] on successful switch',
        build: () {
          when(mockSwitchUseCase('vi'))
              .thenAnswer((_) async => ResultHelper.success(viLocale));
          return bloc;
        },
        seed: () => const LocalizationLoaded(
          currentLocalization: enLocale,
          supportedLocalizations: locales,
        ),
        act: (b) => b.add(const LocalizationSwitchEvent(viLocale)),
        expect: () => [
          isA<LocalizationOperationInProgress>(),
          isA<LocalizationLoaded>()
              .having((s) => s.currentLocalization, 'current', viLocale),
        ],
        verify: (_) => verify(mockSwitchUseCase('vi')).called(1),
      );

      blocTest<LocalizationBloc, LocalizationState>(
        'emits [OperationInProgress, Error] on switch failure',
        build: () {
          when(mockSwitchUseCase('vi')).thenAnswer(
            (_) async => ResultHelper.failure<LocalizationEntity>(
              const ValidationFailure(message: 'Invalid'),
            ),
          );
          return bloc;
        },
        seed: () => const LocalizationLoaded(
          currentLocalization: enLocale,
          supportedLocalizations: locales,
        ),
        act: (b) => b.add(const LocalizationSwitchEvent(viLocale)),
        expect: () => [
          isA<LocalizationOperationInProgress>(),
          isA<LocalizationError>().having((s) => s.message, 'msg', 'Invalid'),
        ],
      );
    });
  });
}
