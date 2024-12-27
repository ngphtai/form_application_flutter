import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constants.dart';
import '../enums/app_enums.dart';

/// [ThemePreference] class serve data from Shared Preference
/// to views in the context of App Themes.
///
/// Functions include:
/// [fetchThemeApp]
/// [changeTheme]
class ThemePreference {
  late SharedPreferences _pref;

  late ThemeType _appTheme;

  ///
  final defaultTheme = ThemeType.dark;

  /// Get appLocal current
  ThemeType get appTheme => _appTheme;

  /// Constructor
  ThemePreference() {
    initialize();
  }

  /// initializer
  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
    _appTheme = ThemeType.dark;
    fetchThemeApp();
  }

  /// This function fetch the language of the user's app.
  ThemeType fetchThemeApp() {
    final themeStored = _pref.getString(PrefsConstants.keyThemeSharedPref);
    if (themeStored == null || themeStored.isEmpty) {
      // Theme default
      _appTheme = defaultTheme;
    } else {
      _appTheme = ThemeType.values.firstWhere((e) => e.name == themeStored);
    }
    return _appTheme;
  }

  /// This function change the app theme.
  Future<void> changeTheme({required ThemeType type}) async {
    _appTheme = type;
    await _pref.setString(PrefsConstants.keyThemeSharedPref, type.name);
  }
}
