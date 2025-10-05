import 'package:flutter/foundation.dart';

class Logger {
  /// Controla si los logs deben mostrarse o no
  /// En producción (release mode) se desactivan automáticamente
  static bool showLogs = !kReleaseMode;

  /// Muestra un mensaje de log normal
  static void log(String message) {
    if (showLogs) {
      debugPrint('[INFO] $message');
    }
  }

  /// Muestra un mensaje de log de error
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (showLogs) {
      debugPrint('[ERROR] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('StackTrace: $stackTrace');
    }
  }

  /// Muestra un mensaje de log de advertencia
  static void warning(String message) {
    if (showLogs) {
      debugPrint('[WARNING] $message');
    }
  }

  /// Muestra un mensaje de log de depuración
  static void debug(String message) {
    if (showLogs) {
      debugPrint('[DEBUG] $message');
    }
  }

  /// Deshabilita completamente todos los logs
  static void disableLogs() {
    showLogs = false;
  }

  /// Habilita los logs (sólo tendrá efecto en modo debug)
  static void enableLogs() {
    showLogs = !kReleaseMode;
  }
}