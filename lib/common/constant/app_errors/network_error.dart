import '/common/logger/app_logger.dart';

import 'app_orther_error.dart';

/// {@template api_error}
/// [NetworkError] is class representing Network errors.
/// Network is not available.
/// {@endtemplate}
class NetworkError extends AppOtherError {
  /// Message description about error
  late final String messageNetworkError;

  /// {@macro network_error_model}
  NetworkError({
    this.messageNetworkError = "Network is not available",
    super.messageError = '',
    super.exception,
  });

  @override
  void logErrorToLogger() {
    AppLogger.instance.e("network have error is $messageNetworkError");
  }

  @override
  List<Object?> get props => [];
}
