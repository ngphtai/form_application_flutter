import 'package:dio/dio.dart';
import 'package:dsoft_form_application/common/constant/constants.dart';

/// [AuthorizationInterceptor] add access token to header when call the API
/// need access token
class AuthorizationInterceptor extends QueuedInterceptor {
  /// Instance variable AuthorizationInterceptor
  static final instance = AuthorizationInterceptor._();

  AuthorizationInterceptor._();

  final _authorizationKey = "Authorization";
  final _authorizationType = "Bearer";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.path = "${APIConstants.baseUrl}${options.path}";
    handler.next(options);
  }
}
