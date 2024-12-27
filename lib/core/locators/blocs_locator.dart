part of 'locators.dart';

///creating [GetIt] for [HomePageBloc]
final diSplashBloc = di<SplashBloc>();
final diHomePageBloc = di<HomePageBloc>();

/// setup locator related to blocs
void setUpBlocsLocator() {
  di.registerFactory(SplashBloc.new);
  di.registerFactory(HomePageBloc.new);
}
