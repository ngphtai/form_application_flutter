part of 'locators.dart';

/// Creating an instance of [GetIt] and storing it in a global variable
/// Initializing the locator.
GetIt di = GetIt.instance;

/// This function registers the widgets/objects in [GetIt]
void setUpLocator() {
  // Cubits need load before
  setUpCubitLocatorBefore();

  // Shared preference
  setUpSharedPrefLocator();

  // Hive
  // setUpHiveLocator();

  // Services need load before
  setUpServicesLocatorBefore();

  // Cubits load after
  setUpCubitLocatorAfter();

  // Data source
  // Local
  // setUpLocalDataSource();

  // Remote
  setUpRemoteDataSource();

  // Repositories
  setUpRepositoriesLocator();

  // UseCases
  setUpUseCasesLocator();

  // Serviceable
  setUpServiceableLocator();

  // Blocs
  setUpBlocsLocator();

  //AppRouter
  setUpAppRoutersLocator();
}
