import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilities/logger.dart';
import '../../../domain/use_cases/localization/get_current_localization_use_case.dart';
import '../../../domain/use_cases/localization/get_supported_localizations_use_case.dart';
import '../../../domain/use_cases/localization/switch_localization_use_case.dart';
import 'localization_event.dart';
import 'localization_state.dart';

/// BLoC for managing localization/language state
///
/// This BLoC handles all localization-related operations including:
/// - Loading the current language
/// - Switching between supported languages
/// - Getting list of supported languages
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc({
    required this.getCurrentLocalizationUseCase,
    required this.getSupportedLocalizationsUseCase,
    required this.switchLocalizationUseCase,
  }) : super(const LocalizationInitial()) {
    on<LocalizationLoadCurrentEvent>(_onLoadCurrent);
    on<LocalizationSwitchEvent>(_onSwitch);
    on<LocalizationGetSupportedEvent>(_onGetSupported);
  }

  final GetCurrentLocalizationUseCase getCurrentLocalizationUseCase;
  final GetSupportedLocalizationsUseCase getSupportedLocalizationsUseCase;
  final SwitchLocalizationUseCase switchLocalizationUseCase;

  /// Load current localization
  Future<void> _onLoadCurrent(
    LocalizationLoadCurrentEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    try {
      emit(const LocalizationLoading());

      AppLogger.info('Loading current localization...');

      final result = await getCurrentLocalizationUseCase();

      await result.fold(
        (failure) async {
          AppLogger.error(
              'Failed to load current localization: ${failure.message}',);
          emit(LocalizationError(message: failure.message));
        },
        (localization) async {
          AppLogger.info(
            'Current localization loaded: ${localization.languageCode}',
          );

          // Also load supported localizations
          final supportedResult = await getSupportedLocalizationsUseCase();
          List<dynamic>? supportedList;

          supportedResult.fold(
            (failure) {
              AppLogger.warning(
                'Could not load supported localizations: ${failure.message}',
              );
            },
            (supported) {
              supportedList = supported;
            },
          );

          emit(
            LocalizationLoaded(
              currentLocalization: localization,
              supportedLocalizations: supportedList?.cast(),
            ),
          );
        },
      );
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error loading localization',
        error: e,
        stackTrace: stackTrace,
      );
      emit(
        LocalizationError(
          message: 'Failed to load localization: $e',
        ),
      );
    }
  }

  /// Switch to a new localization
  Future<void> _onSwitch(
    LocalizationSwitchEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    // Save current state for rollback
    final currentState = state;

    if (currentState is! LocalizationLoaded) {
      emit(
        const LocalizationError(
          message: 'Cannot switch language: localization not loaded',
        ),
      );
      return;
    }

    try {
      emit(LocalizationOperationInProgress(previousState: currentState));

      AppLogger.info('Switching localization to: ${event.languageCode}');

      final result = await switchLocalizationUseCase(event.languageCode);

      await result.fold(
        (failure) async {
          AppLogger.error(
            'Failed to switch localization: ${failure.message}',
          );

          // Rollback to previous state
          emit(currentState);
          emit(LocalizationError(message: failure.message));
        },
        (newLocalization) async {
          AppLogger.info(
            'Successfully switched to: ${newLocalization.languageCode}',
          );

          final updatedState = LocalizationLoaded(
            currentLocalization: newLocalization,
            supportedLocalizations: currentState.supportedLocalizations,
          );

          emit(
            LocalizationOperationSuccess(
              message: 'Language changed to ${newLocalization.languageName}',
              updatedState: updatedState,
            ),
          );

          // Immediately emit the updated state
          emit(updatedState);
        },
      );
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error switching localization',
        error: e,
        stackTrace: stackTrace,
      );

      // Rollback to previous state
      emit(currentState);
      emit(
        LocalizationError(
          message: 'Failed to switch language: $e',
        ),
      );
    }
  }

  /// Get all supported localizations
  Future<void> _onGetSupported(
    LocalizationGetSupportedEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    final currentState = state;

    if (currentState is! LocalizationLoaded) {
      AppLogger.warning(
        'Cannot get supported localizations: localization not loaded',
      );
      return;
    }

    try {
      AppLogger.info('Getting supported localizations...');

      final result = await getSupportedLocalizationsUseCase();

      await result.fold(
        (failure) async {
          AppLogger.error(
            'Failed to get supported localizations: ${failure.message}',
          );
          // Don't emit error, just keep current state
        },
        (supported) async {
          AppLogger.info('Found ${supported.length} supported localizations');

          emit(
            LocalizationLoaded(
              currentLocalization: currentState.currentLocalization,
              supportedLocalizations: supported,
            ),
          );
        },
      );
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error getting supported localizations',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't emit error, just keep current state
    }
  }
}
