import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'app_logger_output.dart';

/// [AppLogger] provides different functions
/// as log in the console whenever developing.
///
/// Functions includes:
/// [t]
/// [d]
/// [i]
/// [w]
/// [e]
/// [f]
class AppLogger {
  static final AppLogger _singleton = AppLogger._();

  ///
  static AppLogger get instance => _singleton;

  late final Logger _logger;

  //final _isEnableLogger = kDebugMode;

  // Always log
  final _isEnableLogger = true;

  AppLogger._() {
    if (_isEnableLogger) {
      final appLoggerOutput = AppLoggerOutput();
      final multiOutput = [appLoggerOutput];
      _logger = Logger(
        output: MultiOutput(multiOutput),
        printer: PrettyPrinter(
          printEmojis: true,
          noBoxingByDefault: false,
          levelEmojis: {
            Level.fatal: '🚨',
            Level.error: '🚨',
            Level.warning: '⚠️',
            Level.info: '❗',
            Level.debug: '🛠️',
          },
          levelColors: {
            Level.trace: AnsiColor.fg(AnsiColor.grey(0.5)),
            Level.debug: const AnsiColor.none(),
            Level.info: const AnsiColor.fg(115),
            Level.warning: const AnsiColor.fg(208),
            Level.error: const AnsiColor.fg(196),
            Level.fatal: const AnsiColor.fg(199),
          },
          // s
          excludePaths: ['package:logger/logger.dart'],
          colors: true,
        ),
      );
    }
  }

  /// Log a message at level [Level.trace].
  void t(String message) {
    if (_isEnableLogger) {
      _logger.t(message);
    }
  }

  /// Log a message at level [Level.debug].
  void d(String message) {
    if (_isEnableLogger) {
      _logger.d(message);
    }
    debugPrint(message);
  }

  /// Log a message at level [Level.info].
  void i(String message) {
    if (_isEnableLogger) {
      _logger.i(message);
    }
  }

  /// Log a message at level [Level.warning].
  void w(String message) {
    if (_isEnableLogger) {
      _logger.w(message);
    }
  }

  /// Log a message at level [Level.error].
  void e(String message) {
    if (_isEnableLogger) {
      _logger.e(message);
    }
  }

  /// Log a message at level [Level.fatal].
  void f(String message) {
    if (_isEnableLogger) {
      _logger.f(message);
    }
  }
}
