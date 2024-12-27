import '/common/logger/app_logger.dart';

import 'app_error.dart';

/// {@template app_other_error}
/// [AppOtherError] is class representing other errors in app.
/// Example: SocketException, Timeout
/// {@endtemplate}
class AppOtherError extends AppError {
  /// Message description about error
  late final String messageError;

  /// Type of exception error
  late final Exception? exception;

  /// {@macro app_other_error}
  AppOtherError({
    required this.messageError,
    required this.exception,
  });

  @override
  void logErrorToLogger() {
    AppLogger.instance.e(messageError);
  }

  @override
  List<Object?> get props => [messageError];
}
