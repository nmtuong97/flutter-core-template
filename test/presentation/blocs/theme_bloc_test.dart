import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/core/errors/failures.dart';
import 'package:flutter_theme_showcase/core/errors/result.dart';
import 'package:flutter_theme_showcase/domain/entities/theme_entity.dart';
import 'package:flutter_theme_showcase/domain/use_cases/theme/get_available_themes_use_case.dart';
import 'package:flutter_theme_showcase/domain/use_cases/theme/get_current_theme_use_case.dart';
import 'package:flutter_theme_showcase/domain/use_cases/theme/manage_theme_mode_use_case.dart';
import 'package:flutter_theme_showcase/domain/use_cases/theme/switch_theme_use_case.dart';
import 'package:flutter_theme_showcase/presentation/blocs/theme/theme_bloc.dart';
import 'package:flutter_theme_showcase/presentation/blocs/theme/theme_event.dart';
import 'package:flutter_theme_showcase/presentation/blocs/theme/theme_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_bloc_test.mocks.dart';

@GenerateMocks([
  GetCurrentThemeUseCase,
  GetAvailableThemesUseCase,
  SwitchThemeUseCase,
  ManageThemeModeUseCase,
])
void main() {
  group('ThemeBloc', () {
    late ThemeBloc bloc;
    late MockGetCurrentThemeUseCase mockGetCurrentThemeUseCase;
    late MockGetAvailableThemesUseCase mockGetAvailableThemesUseCase;
    late MockSwitchThemeUseCase mockSwitchThemeUseCase;
    late MockManageThemeModeUseCase mockManageThemeModeUseCase;

    late ThemeEntity testTheme;
    late List<ThemeEntity> testThemes;

    setUp(() {
      mockGetCurrentThemeUseCase = MockGetCurrentThemeUseCase();
      mockGetAvailableThemesUseCase = MockGetAvailableThemesUseCase();
      mockSwitchThemeUseCase = MockSwitchThemeUseCase();
      mockManageThemeModeUseCase = MockManageThemeModeUseCase();

      bloc = ThemeBloc(
        getCurrentThemeUseCase: mockGetCurrentThemeUseCase,
        getAvailableThemesUseCase: mockGetAvailableThemesUseCase,
        switchThemeUseCase: mockSwitchThemeUseCase,
        manageThemeModeUseCase: mockManageThemeModeUseCase,
      );

      testTheme = const ThemeEntity.createDefault();
      testThemes = [testTheme];
    });

    tearDown(() async {
      await bloc.close();
    });

    test('initial state should be ThemeInitial', () {
      expect(bloc.state, equals(const ThemeInitial()));
    });

    group('ThemeLoadCurrentEvent', () {
      blocTest<ThemeBloc, ThemeState>(
        'should emit [ThemeLoading, ThemeLoaded] when loading is successful',
        build: () {
          when(mockGetCurrentThemeUseCase())
              .thenAnswer((_) async => ResultHelper.success(testTheme));
          when(mockGetAvailableThemesUseCase())
              .thenAnswer((_) async => ResultHelper.success(testThemes));
          when(mockManageThemeModeUseCase.getCurrentThemeMode())
              .thenAnswer((_) async => ResultHelper.success(ThemeMode.system));
          return bloc;
        },
        act: (bloc) => bloc.add(const ThemeLoadCurrentEvent()),
        expect: () => [
          const ThemeLoading(),
          isA<ThemeLoaded>().having(
            (state) => state.currentTheme,
            'currentTheme',
            equals(testTheme),
          ),
        ],
        verify: (_) {
          verify(mockGetCurrentThemeUseCase()).called(1);
          verify(mockGetAvailableThemesUseCase()).called(1);
          verify(mockManageThemeModeUseCase.getCurrentThemeMode()).called(1);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'should emit [ThemeLoading, ThemeError] when current theme '
        'loading fails',
        build: () {
          when(mockGetCurrentThemeUseCase()).thenAnswer(
            (_) async => ResultHelper.failure(
              const ThemeFailure(message: 'Theme not found', code: 'NOT_FOUND'),
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const ThemeLoadCurrentEvent()),
        expect: () => [
          const ThemeLoading(),
          isA<ThemeError>().having(
            (state) => state.message,
            'message',
            equals('Theme not found'),
          ),
        ],
      );
    });

    group('ThemeSwitchEvent', () {
      blocTest<ThemeBloc, ThemeState>(
        'should emit [ThemeOperationInProgress, ThemeOperationSuccess] '
        'when theme switch is successful',
        build: () {
          when(mockSwitchThemeUseCase('cyberpunk'))
              .thenAnswer((_) async => ResultHelper.success(testTheme));
          return bloc;
        },
        seed: () => ThemeLoaded(
          currentTheme: testTheme,
          availableThemes: testThemes,
          themeMode: ThemeMode.system,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
        act: (bloc) => bloc.add(const ThemeSwitchEvent(themeId: 'cyberpunk')),
        expect: () => [
          isA<ThemeOperationInProgress>().having(
            (state) => state.operation,
            'operation',
            contains('cyberpunk'),
          ),
          isA<ThemeOperationSuccess>().having(
            (state) => state.message,
            'message',
            equals('Theme changed successfully'),
          ),
        ],
        verify: (_) {
          verify(mockSwitchThemeUseCase('cyberpunk')).called(1);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'should emit [ThemeOperationInProgress, ThemeError] when theme '
        'switch fails',
        build: () {
          when(mockSwitchThemeUseCase('invalid')).thenAnswer(
            (_) async => ResultHelper.failure(
              const ThemeFailure(message: 'Theme not found', code: 'NOT_FOUND'),
            ),
          );
          return bloc;
        },
        seed: () => ThemeLoaded(
          currentTheme: testTheme,
          availableThemes: testThemes,
          themeMode: ThemeMode.system,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
        act: (bloc) => bloc.add(const ThemeSwitchEvent(themeId: 'invalid')),
        expect: () => [
          isA<ThemeOperationInProgress>(),
          isA<ThemeError>().having(
            (state) => state.message,
            'message',
            equals('Theme not found'),
          ),
        ],
      );
    });

    group('ThemeChangeModeEvent', () {
      blocTest<ThemeBloc, ThemeState>(
        'should emit [ThemeOperationInProgress, ThemeOperationSuccess] '
        'when theme mode change is successful',
        build: () {
          when(mockManageThemeModeUseCase.setThemeMode(ThemeMode.dark))
              .thenAnswer((_) async => ResultHelper.success(null));
          return bloc;
        },
        seed: () => ThemeLoaded(
          currentTheme: testTheme,
          availableThemes: testThemes,
          themeMode: ThemeMode.system,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
        act: (bloc) =>
            bloc.add(const ThemeChangeModeEvent(themeMode: ThemeMode.dark)),
        expect: () => [
          isA<ThemeOperationInProgress>().having(
            (state) => state.operation,
            'operation',
            contains('dark'),
          ),
          isA<ThemeOperationSuccess>().having(
            (state) => state.updatedState.themeMode,
            'themeMode',
            equals(ThemeMode.dark),
          ),
        ],
        verify: (_) {
          verify(mockManageThemeModeUseCase.setThemeMode(ThemeMode.dark))
              .called(1);
        },
      );
    });

    group('ThemeToggleModeEvent', () {
      blocTest<ThemeBloc, ThemeState>(
        'should emit [ThemeOperationInProgress, ThemeOperationSuccess] '
        'when theme mode toggle is successful',
        build: () {
          when(mockManageThemeModeUseCase.toggleThemeMode())
              .thenAnswer((_) async => ResultHelper.success(ThemeMode.dark));
          return bloc;
        },
        seed: () => ThemeLoaded(
          currentTheme: testTheme,
          availableThemes: testThemes,
          themeMode: ThemeMode.light,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
        act: (bloc) => bloc.add(const ThemeToggleModeEvent()),
        expect: () => [
          isA<ThemeOperationInProgress>().having(
            (state) => state.operation,
            'operation',
            equals('Toggling theme mode'),
          ),
          isA<ThemeOperationSuccess>().having(
            (state) => state.updatedState.themeMode,
            'themeMode',
            equals(ThemeMode.dark),
          ),
        ],
        verify: (_) {
          verify(mockManageThemeModeUseCase.toggleThemeMode()).called(1);
        },
      );
    });

    group('ThemeChangeFontSizeEvent', () {
      blocTest<ThemeBloc, ThemeState>(
        'should emit [ThemeOperationSuccess] when font size change is '
        'successful',
        build: () => bloc,
        seed: () => ThemeLoaded(
          currentTheme: testTheme,
          availableThemes: testThemes,
          themeMode: ThemeMode.system,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
        act: (bloc) => bloc.add(const ThemeChangeFontSizeEvent(fontSize: 16)),
        expect: () => [
          isA<ThemeOperationSuccess>().having(
            (state) => state.updatedState.fontSize,
            'fontSize',
            equals(16.0),
          ),
        ],
      );
    });

    group('ThemeChangeFontFamilyEvent', () {
      blocTest<ThemeBloc, ThemeState>(
        'should emit [ThemeOperationSuccess] when font family change is '
        'successful',
        build: () => bloc,
        seed: () => ThemeLoaded(
          currentTheme: testTheme,
          availableThemes: testThemes,
          themeMode: ThemeMode.system,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
        act: (bloc) =>
            bloc.add(const ThemeChangeFontFamilyEvent(fontFamily: 'Inter')),
        expect: () => [
          isA<ThemeOperationSuccess>().having(
            (state) => state.updatedState.fontFamily,
            'fontFamily',
            equals('Inter'),
          ),
        ],
      );
    });
  });
}
