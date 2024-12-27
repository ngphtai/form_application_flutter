part of 'locators.dart';

// Services need before
///creating [GetIt] for [PermissionService]
final diPermissionService = di<PermissionService>();

///creating [GetIt] for [CustomHttpClient]
final diCustomHttpClient = di<CustomHttpClient>();

final diAnalytics = di<FirebaseAnalyticsService>();

/// setup locator related to services loaded before
void setUpServicesLocatorBefore() {
  di.registerSingleton(PermissionService());

  di.registerSingletonAsync<CustomHttpClient>(
    () async {
      final httpClient = HttpClientImpl();
      return httpClient;
    },
  );

  di.registerSingleton<FirebaseAnalyticsService>(FirebaseAnalyticsService());
}
