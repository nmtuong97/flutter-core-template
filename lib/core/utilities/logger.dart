import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Log levels for different types of messages
enum LogLevel {
  debug,
  info,
  warning,
  error,
}

/// Structured logger for the application
class AppLogger {
  static const String _name = 'FlutterThemeShowcase';

  /// Log a debug message
  static void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.debug,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Log an info message
  static void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.info,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Log a warning message
  static void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.warning,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Log an error message
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.error,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Internal logging method
  static void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    // Only log in debug mode or if it's an error/warning
    if (!kDebugMode && level == LogLevel.debug) {
      return;
    }

    final logMessage = _formatMessage(level, message, data);
    final logLevel = _getLogLevel(level);

    // Use Flutter's debugPrint for better performance in release mode
    if (level == LogLevel.debug || level == LogLevel.info) {
      debugPrint(logMessage);
    } else {
      // Use developer.log for warnings and errors with better metadata
      developer.log(
        logMessage,
        name: _name,
        level: logLevel,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Format the log message with level and timestamp
  static String _formatMessage(
    LogLevel level,
    String message,
    Map<String, dynamic>? data,
  ) {
    final timestamp = DateTime.now().toIso8601String();
    final levelString = level.name.toUpperCase();
    final dataString = data != null ? ' | Data: $data' : '';

    return '[$timestamp] [$levelString] $message$dataString';
  }

  /// Convert LogLevel to int for developer.log
  static int _getLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }

  /// Log theme-related operations
  static void theme(String message, {Map<String, dynamic>? data}) {
    debug('THEME: $message', data: data);
  }

  /// Log localization-related operations
  static void localization(String message, {Map<String, dynamic>? data}) {
    debug('L10N: $message', data: data);
  }

  /// Log navigation-related operations
  static void navigation(String message, {Map<String, dynamic>? data}) {
    debug('NAV: $message', data: data);
  }

  /// Log performance-related information
  static void performance(String message, {Map<String, dynamic>? data}) {
    info('PERF: $message', data: data);
  }
}
