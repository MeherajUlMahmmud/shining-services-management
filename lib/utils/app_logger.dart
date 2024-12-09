import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Enum to define the different levels of logs.
enum LogLevel { debug, info, warn, error }

class AppLogger {
  // Singleton pattern to ensure a single instance
  static final AppLogger _instance = AppLogger._internal();

  AppLogger._internal();

  factory AppLogger() {
    return _instance;
  }

  /// Logs a message with the specified log level and optional error/stack trace.
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final String logMessage = _formatLog(level, message, error: error);

    // Output the log based on platform and configuration
    if (kDebugMode) {
      // Print to console in debug mode
      developer.log(
        logMessage,
        level: _getLogLevelValue(level),
        error: error,
        stackTrace: stackTrace,
      );
    }

    // Additional logic for production or file logging could be added here
    _handleProductionLog(logMessage, level, error, stackTrace);
  }

  /// Formats the log message with a timestamp and log level for consistency.
  String _formatLog(LogLevel level, String message, {Object? error}) {
    final timestamp = DateTime.now().toIso8601String();
    final errorMessage = error != null ? '\nError: $error' : '';
    return "[$timestamp] ${level.name.toUpperCase()}: $message$errorMessage";
  }

  /// Returns an integer value for log level filtering or other purposes.
  int _getLogLevelValue(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 0;
      case LogLevel.info:
        return 200;
      case LogLevel.warn:
        return 300;
      case LogLevel.error:
        return 500;
    }
  }

  /// Handles logging in production, such as sending logs to a server.
  void _handleProductionLog(String logMessage, LogLevel level, Object? error,
      StackTrace? stackTrace) {
    // You can add conditions here to send specific logs to an external service
    // e.g., Sentry, Firebase Crashlytics, or log to a file
    if (level == LogLevel.error && !kDebugMode) {
      // Example: Send error logs to an external logging service
      // ExternalLoggingService.sendError(logMessage, error, stackTrace);
    }
  }

  // Convenience methods for specific log levels
  void debug(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.debug, message, error: error, stackTrace: stackTrace);

  void info(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.info, message, error: error, stackTrace: stackTrace);

  void warn(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.warn, message, error: error, stackTrace: stackTrace);

  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.error, message, error: error, stackTrace: stackTrace);
}
