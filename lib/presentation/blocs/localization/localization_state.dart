import 'package:equatable/equatable.dart';

import '../../../domain/entities/localization_entity.dart';

/// Base class for all localization states
abstract class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any localization data is loaded
class LocalizationInitial extends LocalizationState {
  const LocalizationInitial();
}

/// Loading localization data
class LocalizationLoading extends LocalizationState {
  const LocalizationLoading();
}

/// Successfully loaded localization data
class LocalizationLoaded extends LocalizationState {
  const LocalizationLoaded({
    required this.currentLocalization,
    required this.supportedLocalizations,
  });

  final LocalizationEntity currentLocalization;
  final List<LocalizationEntity> supportedLocalizations;

  @override
  List<Object?> get props => [currentLocalization, supportedLocalizations];

  /// Create a copy with updated fields
  LocalizationLoaded copyWith({
    LocalizationEntity? currentLocalization,
    List<LocalizationEntity>? supportedLocalizations,
  }) {
    return LocalizationLoaded(
      currentLocalization: currentLocalization ?? this.currentLocalization,
      supportedLocalizations:
          supportedLocalizations ?? this.supportedLocalizations,
    );
  }
}

/// Error state when localization operations fail
class LocalizationError extends LocalizationState {
  const LocalizationError({
    required this.message,
    this.code,
    this.previousState,
  });

  final String message;
  final String? code;
  final LocalizationLoaded? previousState;

  @override
  List<Object?> get props => [message, code, previousState];
}

/// Operation in progress (e.g., switching locale)
class LocalizationOperationInProgress extends LocalizationState {
  const LocalizationOperationInProgress({
    required this.operation,
    required this.previousState,
  });

  final String operation;
  final LocalizationLoaded previousState;

  @override
  List<Object?> get props => [operation, previousState];
}
