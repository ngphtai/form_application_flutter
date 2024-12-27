part of 'locators.dart';

final diRemoteHttpException = di<RemoteHttpException>();
void setUpErrorsLocator() {
  di.registerSingleton(RemoteHttpException.instance);
}
