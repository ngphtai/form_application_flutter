part of 'locators.dart';

// Cubits need load before
///creating [GetIt] for [ThemeCubit]
final diThemeCubit = di<ThemeCubit>();

///creating [GetIt] for [AppStatusCubit]
// final diAppStatusCubit = di<AppStatusCubit>();

// Cubits load after
// Cubits load after
/// setup locator related to cubit loaded before
void setUpCubitLocatorBefore() {
  di.registerSingleton(ThemeCubit());
  // di.registerSingleton(AppStatusCubit());
}

/// setup locator related to cubit loaded after
void setUpCubitLocatorAfter() {}
