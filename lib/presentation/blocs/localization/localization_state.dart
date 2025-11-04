import 'package:equatable/equatable.dart';

import '../../../domain/entities/localization_entity.dart';

/// Base class for all localization states
abstract class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any localization is loaded
class LocalizationInitial extends LocalizationState {
  const LocalizationInitial();
}

/// State while loading localization
class LocalizationLoading extends LocalizationState {
  const LocalizationLoading();
}

/// State when localization is successfully loaded
class LocalizationLoaded extends LocalizationState {
  const LocalizationLoaded({
    required this.currentLocalization,
    this.supportedLocalizations,
  });

  /// The currently active localization
  final LocalizationEntity currentLocalization;

  /// List of all supported localizations (optional)
  final List<LocalizationEntity>? supportedLocalizations;

  @override
  List<Object?> get props => [currentLocalization, supportedLocalizations];
}

/// State when a localization operation is in progress (e.g., switching language)
class LocalizationOperationInProgress extends LocalizationState {
  const LocalizationOperationInProgress({this.previousState});

  /// The previous loaded state before the operation started
  final LocalizationLoaded? previousState;

  @override
  List<Object?> get props => [previousState];
}

/// State when a localization operation succeeds
class LocalizationOperationSuccess extends LocalizationState {
  const LocalizationOperationSuccess({
    required this.message,
    required this.updatedState,
  });

  /// Success message
  final String message;

  /// The updated state after successful operation
  final LocalizationLoaded updatedState;

  @override
  List<Object?> get props => [message, updatedState];
}

/// State when an error occurs
class LocalizationError extends LocalizationState {
  const LocalizationError({required this.message});

  /// Error message
  final String message;

  @override
  List<Object?> get props => [message];
}
