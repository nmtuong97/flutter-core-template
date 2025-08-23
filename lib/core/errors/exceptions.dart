/// Base class for all custom exceptions
abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.stackTrace,
  });

  /// Human-readable error message
  final String message;

  /// Optional error code for specific handling
  final String? code;

  /// Optional stack trace
  final StackTrace? stackTrace;

  @override
  String toString() => 'AppException: $message (Code: $code)';
}

/// Exception thrown when caching operations fail
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code = 'CACHE_EXCEPTION',
    super.stackTrace,
  });
}

/// Exception thrown when validation fails
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code = 'VALIDATION_EXCEPTION',
    super.stackTrace,
  });
}

/// Exception thrown when server/network operations fail
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code = 'SERVER_EXCEPTION',
    super.stackTrace,
  });
}

/// Exception thrown when local storage operations fail
class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code = 'STORAGE_EXCEPTION',
    super.stackTrace,
  });
}

/// Exception thrown when theme operations fail
class ThemeException extends AppException {
  const ThemeException({
    required super.message,
    super.code = 'THEME_EXCEPTION',
    super.stackTrace,
  });
}

/// Exception thrown when localization operations fail
class LocalizationException extends AppException {
  const LocalizationException({
    required super.message,
    super.code = 'LOCALIZATION_EXCEPTION',
    super.stackTrace,
  });
}
