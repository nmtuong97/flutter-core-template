import 'dart:async';

import 'package:flutter/foundation.dart';

import '../utilities/logger.dart';
import 'exceptions.dart';
import 'failures.dart';

/// Global error handler for managing uncaught exceptions and errors
class GlobalErrorHandler {
  factory GlobalErrorHandler() => _instance;
  GlobalErrorHandler._internal();
  static final GlobalErrorHandler _instance = GlobalErrorHandler._internal();

  /// Initialize global error handling
  static void initialize() {
    // Handle Flutter framework errors
    FlutterError.onError = _instance._handleFlutterError;

    // Handle errors outside of Flutter framework
    PlatformDispatcher.instance.onError = (error, stack) {
      _instance._handlePlatformError(error, stack);
      return true;
    };

    // Handle async errors
    runZonedGuarded(() {}, _instance._handleAsyncError);
  }

  /// Handle Flutter framework errors
  void _handleFlutterError(FlutterErrorDetails details) {
    AppLogger.error(
      'Flutter Error: ${details.exception}',
      error: details.exception,
      stackTrace: details.stack,
    );

    // In debug mode, show the red screen
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    }
  }

  /// Handle platform errors
  bool _handlePlatformError(Object error, StackTrace stack) {
    AppLogger.error(
      'Platform Error: $error',
      error: error,
      stackTrace: stack,
    );
    return true;
  }

  /// Handle async errors
  void _handleAsyncError(Object error, StackTrace stack) {
    AppLogger.error(
      'Async Error: $error',
      error: error,
      stackTrace: stack,
    );
  }

  /// Convert exceptions to appropriate failures
  static Failure handleException(Object exception) {
    if (exception is AppException) {
      return _mapExceptionToFailure(exception);
    }

    // Handle standard Dart exceptions
    if (exception is FormatException) {
      return ValidationFailure(message: exception.message);
    }

    if (exception is TimeoutException) {
      return const ServerFailure(message: 'Operation timed out');
    }

    // Generic exception handling
    return ServerFailure(
      message: 'An unexpected error occurred: $exception',
    );
  }

  /// Map custom exceptions to corresponding failures
  static Failure _mapExceptionToFailure(AppException exception) {
    switch (exception) {
      case CacheException _:
        return CacheFailure(message: exception.message, code: exception.code);
      case ValidationException _:
        return ValidationFailure(
          message: exception.message,
          code: exception.code,
        );
      case ServerException _:
        return ServerFailure(message: exception.message, code: exception.code);
      case StorageException _:
        return StorageFailure(message: exception.message, code: exception.code);
      case ThemeException _:
        return ThemeFailure(message: exception.message, code: exception.code);
      case LocalizationException _:
        return LocalizationFailure(
          message: exception.message,
          code: exception.code,
        );
      default:
        return ServerFailure(
          message: exception.message,
          code: exception.code,
        );
    }
  }
}
