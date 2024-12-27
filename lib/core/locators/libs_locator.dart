part of 'locators.dart';

final diConnectivity = di<Connectivity>();

final diDio = di<Dio>();

void setUpLibsLocator() {
  di.registerLazySingleton(Connectivity.new);

  di.registerLazySingleton(() {
    return Dio(BaseOptions(
      connectTimeout:
          const Duration(milliseconds: AppConstants.connectTimeoutRequestAPI),
      receiveTimeout:
          const Duration(milliseconds: AppConstants.timeoutRequestAPI),
    ));
  });
}
