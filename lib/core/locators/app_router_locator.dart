part of 'locators.dart';

final diAppRouter = di<AppRouter>();

void setUpAppRoutersLocator() {
  di.registerSingleton(AppRouter());
}
