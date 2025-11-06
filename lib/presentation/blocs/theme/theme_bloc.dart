import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilities/logger.dart';
import '../../../domain/use_cases/theme/get_available_themes_use_case.dart';
import '../../../domain/use_cases/theme/get_current_theme_use_case.dart';
import '../../../domain/use_cases/theme/manage_font_family_use_case.dart';
import '../../../domain/use_cases/theme/manage_font_size_use_case.dart';
import '../../../domain/use_cases/theme/manage_theme_mode_use_case.dart';
import '../../../domain/use_cases/theme/switch_theme_use_case.dart';
import 'theme_event.dart';
import 'theme_state.dart';

/// BLoC for managing theme state
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required this.getCurrentThemeUseCase,
    required this.getAvailableThemesUseCase,
    required this.switchThemeUseCase,
    required this.manageThemeModeUseCase,
    required this.manageFontSizeUseCase,
    required this.manageFontFamilyUseCase,
  }) : super(const ThemeInitial()) {
    on<ThemeLoadCurrentEvent>(_onLoadCurrent);
    on<ThemeLoadAvailableEvent>(_onLoadAvailable);
    on<ThemeSwitchEvent>(_onSwitchTheme);
    on<ThemeChangeModeEvent>(_onChangeMode);
    on<ThemeToggleModeEvent>(_onToggleMode);
    on<ThemeChangeFontSizeEvent>(_onChangeFontSize);
    on<ThemeChangeFontFamilyEvent>(_onChangeFontFamily);
    on<ThemeResetToDefaultEvent>(_onResetToDefault);
  }

  final GetCurrentThemeUseCase getCurrentThemeUseCase;
  final GetAvailableThemesUseCase getAvailableThemesUseCase;
  final SwitchThemeUseCase switchThemeUseCase;
  final ManageThemeModeUseCase manageThemeModeUseCase;
  final ManageFontSizeUseCase manageFontSizeUseCase;
  final ManageFontFamilyUseCase manageFontFamilyUseCase;

  /// Load current theme and initial data
  Future<void> _onLoadCurrent(
    ThemeLoadCurrentEvent event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      emit(const ThemeLoading());

      AppLogger.theme('Loading current theme and settings');

      // Load all theme settings
      final currentThemeResult = await getCurrentThemeUseCase();
      final availableThemesResult = await getAvailableThemesUseCase();
      final themeModeResult =
          await manageThemeModeUseCase.getCurrentThemeMode();
      final fontSizeResult = await manageFontSizeUseCase.getCurrentFontSize();
      final fontFamilyResult =
          await manageFontFamilyUseCase.getCurrentFontFamily();

      // Handle results
      await currentThemeResult.fold(
        (failure) async {
          AppLogger.error('Failed to load current theme: ${failure.message}');
          emit(
            ThemeError(
              message: failure.message,
              code: failure.code ?? 'THEME_LOAD_ERROR',
            ),
          );
        },
        (currentTheme) async {
          await availableThemesResult.fold(
            (failure) async {
              AppLogger.error(
                'Failed to load available themes: ${failure.message}',
              );
              emit(
                ThemeError(
                  message: failure.message,
                  code: failure.code ?? 'THEMES_LOAD_ERROR',
                ),
              );
            },
            (availableThemes) async {
              await themeModeResult.fold(
                (failure) async {
                  AppLogger.error(
                    'Failed to load theme mode: ${failure.message}',
                  );
                  emit(
                    ThemeError(
                      message: failure.message,
                      code: failure.code ?? 'THEME_MODE_LOAD_ERROR',
                    ),
                  );
                },
                (themeMode) async {
                  await fontSizeResult.fold(
                    (failure) async {
                      AppLogger.error(
                        'Failed to load font size: ${failure.message}',
                      );
                      emit(
                        ThemeError(
                          message: failure.message,
                          code: failure.code ?? 'FONT_SIZE_LOAD_ERROR',
                        ),
                      );
                    },
                    (fontSize) async {
                      await fontFamilyResult.fold(
                        (failure) async {
                          AppLogger.error(
                            'Failed to load font family: ${failure.message}',
                          );
                          emit(
                            ThemeError(
                              message: failure.message,
                              code: failure.code ?? 'FONT_FAMILY_LOAD_ERROR',
                            ),
                          );
                        },
                        (fontFamily) async {
                          AppLogger.theme('Theme data loaded successfully');
                          emit(
                            ThemeLoaded(
                              currentTheme: currentTheme,
                              availableThemes: availableThemes,
                              themeMode: themeMode,
                              fontSize: fontSize,
                              fontFamily: fontFamily,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error loading theme', error: e);
      emit(
        const ThemeError(
          message: 'An unexpected error occurred while loading theme',
          code: 'UNEXPECTED_ERROR',
        ),
      );
    }
  }

  /// Load available themes
  Future<void> _onLoadAvailable(
    ThemeLoadAvailableEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) {
      add(const ThemeLoadCurrentEvent());
      return;
    }

    final currentState = state as ThemeLoaded;

    try {
      emit(
        ThemeOperationInProgress(
          operation: 'Loading available themes',
          previousState: currentState,
        ),
      );

      final result = await getAvailableThemesUseCase();

      result.fold(
        (failure) {
          AppLogger.error(
            'Failed to load available themes: ${failure.message}',
          );
          emit(
            ThemeError(
              message: failure.message,
              code: failure.code ?? 'THEMES_LOAD_ERROR',
              previousState: currentState,
            ),
          );
        },
        (availableThemes) {
          AppLogger.theme('Available themes loaded successfully');
          emit(currentState.copyWith(availableThemes: availableThemes));
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error loading available themes', error: e);
      emit(
        ThemeError(
          message: 'Failed to load available themes',
          code: 'UNEXPECTED_ERROR',
          previousState: currentState,
        ),
      );
    }
  }

  /// Switch to a different theme
  Future<void> _onSwitchTheme(
    ThemeSwitchEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) {
      add(const ThemeLoadCurrentEvent());
      return;
    }

    final currentState = state as ThemeLoaded;

    try {
      emit(
        ThemeOperationInProgress(
          operation: 'Switching theme to ${event.themeId}',
          previousState: currentState,
        ),
      );

      final result = await switchThemeUseCase(event.themeId);

      result.fold(
        (failure) {
          AppLogger.error('Failed to switch theme: ${failure.message}');
          emit(
            ThemeError(
              message: failure.message,
              code: failure.code ?? 'THEME_SWITCH_ERROR',
              previousState: currentState,
            ),
          );
        },
        (newTheme) {
          AppLogger.theme('Theme switched successfully to ${event.themeId}');
          final updatedState = currentState.copyWith(currentTheme: newTheme);
          emit(
            ThemeOperationSuccess(
              message: 'Theme changed successfully',
              updatedState: updatedState,
            ),
          );
          // Immediately transition to ThemeLoaded for continued interactions
          emit(updatedState);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error switching theme', error: e);
      emit(
        ThemeError(
          message: 'Failed to switch theme',
          code: 'UNEXPECTED_ERROR',
          previousState: currentState,
        ),
      );
    }
  }

  /// Change theme mode
  Future<void> _onChangeMode(
    ThemeChangeModeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) {
      add(const ThemeLoadCurrentEvent());
      return;
    }

    final currentState = state as ThemeLoaded;

    try {
      emit(
        ThemeOperationInProgress(
          operation: 'Changing theme mode to ${event.themeMode}',
          previousState: currentState,
        ),
      );

      final result = await manageThemeModeUseCase.setThemeMode(event.themeMode);

      result.fold(
        (failure) {
          AppLogger.error('Failed to change theme mode: ${failure.message}');
          emit(
            ThemeError(
              message: failure.message,
              code: failure.code ?? 'THEME_MODE_ERROR',
              previousState: currentState,
            ),
          );
        },
        (_) {
          AppLogger.theme(
            'Theme mode changed successfully to ${event.themeMode}',
          );
          final updatedState =
              currentState.copyWith(themeMode: event.themeMode);
          emit(
            ThemeOperationSuccess(
              message: 'Theme mode changed successfully',
              updatedState: updatedState,
            ),
          );
          // Immediately transition to ThemeLoaded for continued interactions
          emit(updatedState);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error changing theme mode', error: e);
      emit(
        ThemeError(
          message: 'Failed to change theme mode',
          code: 'UNEXPECTED_ERROR',
          previousState: currentState,
        ),
      );
    }
  }

  /// Toggle theme mode
  Future<void> _onToggleMode(
    ThemeToggleModeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) {
      add(const ThemeLoadCurrentEvent());
      return;
    }

    final currentState = state as ThemeLoaded;

    try {
      emit(
        ThemeOperationInProgress(
          operation: 'Toggling theme mode',
          previousState: currentState,
        ),
      );

      final result = await manageThemeModeUseCase.toggleThemeMode();

      result.fold(
        (failure) {
          AppLogger.error('Failed to toggle theme mode: ${failure.message}');
          emit(
            ThemeError(
              message: failure.message,
              code: failure.code ?? 'THEME_TOGGLE_ERROR',
              previousState: currentState,
            ),
          );
        },
        (newThemeMode) {
          AppLogger.theme('Theme mode toggled successfully to $newThemeMode');
          final updatedState = currentState.copyWith(themeMode: newThemeMode);
          emit(
            ThemeOperationSuccess(
              message: 'Theme mode toggled successfully',
              updatedState: updatedState,
            ),
          );
          // Immediately transition to ThemeLoaded for continued interactions
          emit(updatedState);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error toggling theme mode', error: e);
      emit(
        ThemeError(
          message: 'Failed to toggle theme mode',
          code: 'UNEXPECTED_ERROR',
          previousState: currentState,
        ),
      );
    }
  }

  /// Change font size
  Future<void> _onChangeFontSize(
    ThemeChangeFontSizeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) {
      add(const ThemeLoadCurrentEvent());
      return;
    }

    final currentState = state as ThemeLoaded;

    try {
      emit(
        ThemeOperationInProgress(
          operation: 'Changing font size to ${event.fontSize}',
          previousState: currentState,
        ),
      );

      final result = await manageFontSizeUseCase.setFontSize(event.fontSize);

      result.fold(
        (failure) {
          AppLogger.error('Failed to change font size: ${failure.message}');
          emit(
            ThemeError(
              message: failure.message,
              code: failure.code ?? 'FONT_SIZE_ERROR',
              previousState: currentState,
            ),
          );
        },
        (_) {
          AppLogger.theme(
              'Font size changed successfully to ${event.fontSize}',);
          final updatedState = currentState.copyWith(fontSize: event.fontSize);
          emit(
            ThemeOperationSuccess(
              message: 'Font size changed successfully',
              updatedState: updatedState,
            ),
          );
          // Immediately transition to ThemeLoaded for continued interactions
          emit(updatedState);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error changing font size', error: e);
      emit(
        ThemeError(
          message: 'Failed to change font size',
          code: 'UNEXPECTED_ERROR',
          previousState: currentState,
        ),
      );
    }
  }

  /// Change font family
  Future<void> _onChangeFontFamily(
    ThemeChangeFontFamilyEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) {
      add(const ThemeLoadCurrentEvent());
      return;
    }

    final currentState = state as ThemeLoaded;

    try {
      emit(
        ThemeOperationInProgress(
          operation: 'Changing font family to ${event.fontFamily}',
          previousState: currentState,
        ),
      );

      final result =
          await manageFontFamilyUseCase.setFontFamily(event.fontFamily);

      result.fold(
        (failure) {
          AppLogger.error('Failed to change font family: ${failure.message}');
          emit(
            ThemeError(
              message: failure.message,
              code: failure.code ?? 'FONT_FAMILY_ERROR',
              previousState: currentState,
            ),
          );
        },
        (_) {
          AppLogger.theme(
            'Font family changed successfully to ${event.fontFamily}',
          );
          final updatedState =
              currentState.copyWith(fontFamily: event.fontFamily);
          emit(
            ThemeOperationSuccess(
              message: 'Font family changed successfully',
              updatedState: updatedState,
            ),
          );
          // Immediately transition to ThemeLoaded for continued interactions
          emit(updatedState);
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error changing font family', error: e);
      emit(
        ThemeError(
          message: 'Failed to change font family',
          code: 'UNEXPECTED_ERROR',
          previousState: currentState,
        ),
      );
    }
  }

  /// Reset theme to default
  Future<void> _onResetToDefault(
    ThemeResetToDefaultEvent event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      emit(
        const ThemeOperationInProgress(
          operation: 'Resetting to default theme',
        ),
      );

      // Switch to default theme
      final result = await switchThemeUseCase('default');

      result.fold(
        (failure) {
          AppLogger.error(
            'Failed to reset to default theme: ${failure.message}',
          );
          emit(
            ThemeError(
              message: failure.message,
              code: failure.code ?? 'RESET_ERROR',
            ),
          );
        },
        (defaultTheme) {
          AppLogger.theme('Reset to default theme successfully');

          // Reload all theme data
          add(const ThemeLoadCurrentEvent());
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error resetting theme', error: e);
      emit(
        const ThemeError(
          message: 'Failed to reset theme',
          code: 'UNEXPECTED_ERROR',
        ),
      );
    }
  }
}
