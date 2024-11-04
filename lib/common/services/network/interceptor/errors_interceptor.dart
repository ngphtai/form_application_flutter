import 'package:dio/dio.dart';

import '../../../../core/locators/locators.dart';

/// [ErrorsInterceptor] used to handler error when API response
class ErrorsInterceptor extends QueuedInterceptor {
  /// Instance variable ErrorsInterceptor
  static final instance = ErrorsInterceptor._();
  ErrorsInterceptor._();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final remoteException = diRemoteHttpException;
    final appError = remoteException.fromDioError(err);
    // If request is occur an error without AppOtherError type
    handler.reject(
      DioError(
        requestOptions: err.requestOptions,
        response: Response(
          requestOptions: err.requestOptions,
          data: appError,
        ),
      ),
    );
  }
}
