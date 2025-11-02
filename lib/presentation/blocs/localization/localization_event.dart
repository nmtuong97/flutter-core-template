import 'package:equatable/equatable.dart';

import '../../../domain/entities/localization_entity.dart';

/// Base class for all localization events
abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object?> get props => [];
}

/// Load current localization from repository
class LocalizationLoadCurrentEvent extends LocalizationEvent {
  const LocalizationLoadCurrentEvent();
}

/// Load all supported localizations
class LocalizationLoadSupportedEvent extends LocalizationEvent {
  const LocalizationLoadSupportedEvent();
}

/// Switch to a different localization
class LocalizationSwitchEvent extends LocalizationEvent {
  const LocalizationSwitchEvent(this.newLocale);

  final LocalizationEntity newLocale;

  @override
  List<Object?> get props => [newLocale];
}
