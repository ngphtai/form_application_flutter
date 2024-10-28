//ignore_for_file: one_member_abstracts

import 'package:equatable/equatable.dart';

/// {@template app_error}
/// [AppError] is interface for different other errors in app.
/// {@endtemplate}
abstract class AppError extends Equatable {
  /// log error to Firebase Logger
  void logErrorToLogger();
}
