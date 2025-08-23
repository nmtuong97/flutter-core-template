import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    this.code,
  });

  /// Human-readable error message
  final String message;

  /// Optional error code for specific handling
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

/// Failure when caching operations fail
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code = 'CACHE_ERROR',
  });
}

/// Failure when validation fails
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 'VALIDATION_ERROR',
  });
}

/// Failure when server/network operations fail
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code = 'SERVER_ERROR',
  });
}

/// Failure when local storage operations fail
class StorageFailure extends Failure {
  const StorageFailure({
    required super.message,
    super.code = 'STORAGE_ERROR',
  });
}

/// Failure when theme operations fail
class ThemeFailure extends Failure {
  const ThemeFailure({
    required super.message,
    super.code = 'THEME_ERROR',
  });
}

/// Failure when localization operations fail
class LocalizationFailure extends Failure {
  const LocalizationFailure({
    required super.message,
    super.code = 'LOCALIZATION_ERROR',
  });
}
