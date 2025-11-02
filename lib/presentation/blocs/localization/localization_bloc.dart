import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilities/logger.dart';
import '../../../domain/use_cases/localization/get_current_localization_use_case.dart';
import '../../../domain/use_cases/localization/get_supported_localizations_use_case.dart';
import '../../../domain/use_cases/localization/switch_localization_use_case.dart';
import 'localization_event.dart';
import 'localization_state.dart';

/// BLoC for managing localization state
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc({
    required this.getCurrentLocalizationUseCase,
    required this.getSupportedLocalizationsUseCase,
    required this.switchLocalizationUseCase,
  }) : super(const LocalizationInitial()) {
    on<LocalizationLoadCurrentEvent>(_onLoadCurrent);
    on<LocalizationLoadSupportedEvent>(_onLoadSupported);
    on<LocalizationSwitchEvent>(_onSwitch);
  }

  final GetCurrentLocalizationUseCase getCurrentLocalizationUseCase;
  final GetSupportedLocalizationsUseCase getSupportedLocalizationsUseCase;
  final SwitchLocalizationUseCase switchLocalizationUseCase;

  /// Load current localization and supported localizations
  Future<void> _onLoadCurrent(
    LocalizationLoadCurrentEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    try {
      emit(const LocalizationLoading());

      AppLogger.info('Loading current localization and supported locales');

      // Load current localization - early return on failure
      final currentLocalizationResult =
          await getCurrentLocalizationUseCase();
      final currentLocalization = currentLocalizationResult.fold(
        (failure) {
          AppLogger.error(
            'Failed to load current localization: ${failure.message}',
          );
          emit(
            LocalizationError(
              message: failure.message,
              code: failure.code ?? 'LOCALIZATION_LOAD_ERROR',
            ),
          );
          return null;
        },
        (localization) => localization,
      );
      if (currentLocalization == null) return;

      // Load supported localizations - early return on failure
      final supportedLocalizationsResult =
          await getSupportedLocalizationsUseCase();
      final supportedLocalizations = supportedLocalizationsResult.fold(
        (failure) {
          AppLogger.error(
            'Failed to load supported localizations: ${failure.message}',
          );
          emit(
            LocalizationError(
              message: failure.message,
              code: failure.code ?? 'SUPPORTED_LOCALIZATIONS_LOAD_ERROR',
            ),
          );
          return null;
        },
        (localizations) => localizations,
      );
      if (supportedLocalizations == null) return;

      // All data loaded successfully
      AppLogger.info('Localization data loaded successfully');
      emit(
        LocalizationLoaded(
          currentLocalization: currentLocalization,
          supportedLocalizations: supportedLocalizations,
        ),
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error loading localization', error: e);
      emit(
        const LocalizationError(
          message: 'An unexpected error occurred while loading localization',
          code: 'UNEXPECTED_ERROR',
        ),
      );
    }
  }

  /// Load supported localizations only
  Future<void> _onLoadSupported(
    LocalizationLoadSupportedEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    if (state is! LocalizationLoaded) {
      add(const LocalizationLoadCurrentEvent());
      return;
    }

    final currentState = state as LocalizationLoaded;

    try {
      emit(
        LocalizationOperationInProgress(
          operation: 'Loading supported localizations',
          previousState: currentState,
        ),
      );

      final result = await getSupportedLocalizationsUseCase();

      result.fold(
        (failure) {
          AppLogger.error(
            'Failed to load supported localizations: ${failure.message}',
          );
          emit(
            LocalizationError(
              message: failure.message,
              code: failure.code ?? 'SUPPORTED_LOCALIZATIONS_LOAD_ERROR',
              previousState: currentState,
            ),
          );
        },
        (supportedLocalizations) {
          AppLogger.info('Supported localizations loaded successfully');
          emit(
            currentState.copyWith(
              supportedLocalizations: supportedLocalizations,
            ),
          );
        },
      );
    } on Exception catch (e) {
      AppLogger.error(
        'Unexpected error loading supported localizations',
        error: e,
      );
      emit(
        LocalizationError(
          message: 'Failed to load supported localizations',
          code: 'UNEXPECTED_ERROR',
          previousState: currentState,
        ),
      );
    }
  }

  /// Switch to a different localization
  Future<void> _onSwitch(
    LocalizationSwitchEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    if (state is! LocalizationLoaded) {
      add(const LocalizationLoadCurrentEvent());
      return;
    }

    final currentState = state as LocalizationLoaded;

    try {
      emit(
        LocalizationOperationInProgress(
          operation:
              'Switching to ${event.newLocale.languageName}',
          previousState: currentState,
        ),
      );

      final result = await switchLocalizationUseCase(
        event.newLocale.locale.toString(),
      );

      result.fold(
        (failure) {
          AppLogger.error(
            'Failed to switch localization: ${failure.message}',
          );
          emit(
            LocalizationError(
              message: failure.message,
              code: failure.code ?? 'LOCALIZATION_SWITCH_ERROR',
              previousState: currentState,
            ),
          );
        },
        (newLocalization) {
          AppLogger.info(
            'Switched to ${newLocalization.languageName} successfully',
          );
          emit(
            currentState.copyWith(
              currentLocalization: newLocalization,
            ),
          );
        },
      );
    } on Exception catch (e) {
      AppLogger.error('Unexpected error switching localization', error: e);
      emit(
        LocalizationError(
          message: 'Failed to switch localization',
          code: 'UNEXPECTED_ERROR',
          previousState: currentState,
        ),
      );
    }
  }
}
