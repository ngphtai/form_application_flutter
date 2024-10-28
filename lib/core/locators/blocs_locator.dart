part of 'locators.dart';

///creating [GetIt] for [HomePageBloc]
final diSplashBloc = di<SplashBloc>();

// ///creating [GetIt] for [HomePageBloc]
// final diHomeBloc = di<HomePageBloc>();

/// setup locator related to blocs
void setUpBlocsLocator() {
  di.registerFactory(SplashBloc.new);
  // di.registerFactory(HomePageBloc.new);
}
