part of 'constants.dart';

/// [PrefsConstants] file contains the variables default variables
/// or key of shared prefs in app.
class PrefsConstants {
  /// Shared Preference key
  /// keys of language code first save Shared Preference
  ///
  /// It is only used for Android below TIRAMISU version
  /// Because Android below TIRAMISU does not support pref-language selection,
  /// but it is expected that the default language when starting the app for
  /// the first time is ja, instead of en as the default system language
  static const keyLanguageCodeSharedPref =
      "language_first_save_shared_pref";

  /// keys of theme Shared Preference
  static const keyThemeSharedPref = "theme_shared_pref";

  /// keys of auth logged Shared Preference
  static const keyAuthLoggedSharedPref = "auth_logged_shared_pref";
}
