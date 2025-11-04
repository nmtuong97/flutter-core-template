import 'package:equatable/equatable.dart';

/// Base class for all localization events
abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load the current localization
class LocalizationLoadCurrentEvent extends LocalizationEvent {
  const LocalizationLoadCurrentEvent();
}

/// Event to switch to a new localization
class LocalizationSwitchEvent extends LocalizationEvent {
  const LocalizationSwitchEvent({required this.languageCode});

  /// The language code to switch to (e.g., 'en', 'vi')
  final String languageCode;

  @override
  List<Object?> get props => [languageCode];
}

/// Event to get all supported localizations
class LocalizationGetSupportedEvent extends LocalizationEvent {
  const LocalizationGetSupportedEvent();
}
