part of 'constants.dart';

/// [AppConstants] file contains the variables.
/// They can be used instead of default variables or key of shared prefs in app.
class AppConstants {
  /// App Name
  static const appName = "";

  /// Value of app default using in app, this value will be used when
  /// user has not selected a pref-language in app
  /// or language of device unsupported in app.
  static const appDefaultLocalization = "en";

  /// Value timeout of request API
  static const timeoutRequestAPI = 30000;

  /// Value connectTimeout of request API
  static const connectTimeoutRequestAPI = 30000;

  /// Missing Initialization Exception
  static const exceptionNotInit = 'FileLog is not initialized!';

  /// Folder name to storage log files
  static const directoryNameLogging = 'file_logger_storage';

  /// File name to log events
  static const fileLoggingEvents = 'file_log_events.json';

  /// File name to store output logger in console app
  static const fileOutputLoggerInfo = 'withMultiOutput.text';

  /// Key using in interceptor
  static const isAuthenticationKeyInterceptor = "isAuthentication";

  /// Folder name of output logger
  static const folderNameOutputLogger = "FaceLogOutputLogger";
}
