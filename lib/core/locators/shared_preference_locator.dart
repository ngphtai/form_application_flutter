part of 'locators.dart';

final diThemePreference = di<ThemePreference>();

/// setup locator related to shared preference
void setUpSharedPrefLocator() {
  di.registerSingleton(ThemePreference());
}
