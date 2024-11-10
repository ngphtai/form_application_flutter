import 'app_error.dart';

/// {@template api_error}
/// [APIError] is class representing API errors.
/// {@endtemplate}
class APIError extends AppError {
  /// Init [APIError]
  /// Code status of error
  late final int? codeStatus;

  /// Code detail of error
  late final String? codeDetail;

  /// Message detail of error
  late final String message;

  /// {@macro api_error_model}
  APIError({
    this.codeStatus,
    this.codeDetail,
    this.message = "", // TODO: Add default error when do not find error
  });

  @override
  void logErrorToLogger() {
    // TODO: implement logErrorToLogger
  }

  @override
  List<Object?> get props => [];
}
