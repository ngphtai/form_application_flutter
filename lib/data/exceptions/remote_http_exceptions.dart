import 'dart:convert';

import 'package:dio/dio.dart';

import '../../common/constant/app_errors/api_error.dart';
import '../../common/constant/app_errors/app_error.dart';
import '../../common/constant/app_errors/app_orther_error.dart';
import '../../common/constant/app_errors/network_error.dart';
import '../../common/services/app_status_service.dart';
// import '../../core/language/generated/l10n.dart';

/// {@template remote_http_exception}
/// [RemoteHttpException] used to handle api error
/// {@endtemplate}
class RemoteHttpException implements Exception {
  static final _singleton = RemoteHttpException._();

  /// Singleton
  static RemoteHttpException get instance => _singleton;

  /// {@macro remote_http_exception}
  RemoteHttpException._();

  /// AppError
  late final AppError appError;

  String _messageErrorDefault = "";

  /// {@macro remote_http_exception}
  AppError fromDioError(DioError error) {
    // _messageErrorDefault = SLang.current.somethingWentWrongError;
    switch (error.type) {
      case DioExceptionType.cancel:
        return _handleCancelError(error);
      case DioExceptionType.connectionTimeout:
        return _handleTimeoutError(error);
      case DioExceptionType.receiveTimeout:
        return _handleTimeoutError(error);
      case DioExceptionType.sendTimeout:
        return _handleTimeoutError(error);
      case DioExceptionType.badResponse:
        return _handleResponseError(error);
      case DioExceptionType.badCertificate:
        return _handleOtherError(error);
      case DioExceptionType.connectionError:
        return _handleOtherError(error);
      default:
        return _handleResponseError(error);
    }
  }

  AppError _handleOtherError(DioError error) {
    final otherError = AppOtherError(
        exception: error,
        // messageError: SLang.current.appUnableConnectServer,
        messageError: error.message.toString());
    return otherError;
  }

  AppError _handleTimeoutError(DioError error) {
    final statusCode = error.response?.statusCode;
    _logErrorToFirebase(
        message: error.message.toString(),
        statusCode: statusCode,
        apiRequest: error.requestOptions.path);
    final hintMessage = _getMessageServerError(
      path: error.requestOptions.path,
      statusCode: statusCode,
      codeDetail: null,
      errorType: error.type,
    );
    final otherError = AppOtherError(
      exception: error,
      messageError: hintMessage,
    );
    return otherError;
  }

  AppError _handleCancelError(DioError error) {
    if (error.response != null) {
      if (error.response?.data is NetworkError) {
        return NetworkError();
      }
    }
    return APIError(
      codeStatus: error.response?.statusCode,
      message: error.message.toString(),
    );
  }

  AppError _handleResponseError(DioError error) {
    if (error.response != null) {
      final statusCode = error.response?.statusCode;
      final dataError = error.response?.data is String
          ? jsonDecode(error.response?.data)
          : error.response?.data;
      final codeDetail = dataError["error"]["code"];
      final message = dataError["error"]["message"];
      _logErrorToFirebase(
          message: message,
          statusCode: statusCode,
          codeDetail: '$codeDetail',
          apiRequest: error.requestOptions.path);
      final hintMessage = _getMessageServerError(
        path: error.requestOptions.path,
        statusCode: statusCode,
        codeDetail: codeDetail,
        messageResponse: message,
      );
      return APIError(
        codeStatus: statusCode,
        codeDetail: "$codeDetail",
        message: hintMessage,
      );
    }
    _logErrorToFirebase(
        message: error.message.toString(),
        statusCode: error.response?.statusCode,
        apiRequest: error.requestOptions.path);
    return APIError(
      codeStatus: error.response?.statusCode,
      message: _getMessageServerError(
        path: error.requestOptions.path,
        isUndefinedError: true,
      ),
    );
  }

  void _logErrorToFirebase({
    required String message,
    int? statusCode,
    required String apiRequest,
    String? codeDetail,
  }) {
    // LOGGING
  }

  String _getMessageServerError({
    required String path,
    int? statusCode,
    dynamic codeDetail,
    String? messageResponse,
    DioErrorType? errorType,
    bool? isUndefinedError,
  }) {
    return messageResponse ?? _messageErrorDefault;
  }
}
