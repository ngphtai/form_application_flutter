import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/locators/locators.dart';
import '../../constant/constants.dart';
import '../../logger/app_logger.dart';
import 'interceptor/authorization_interceptor.dart';
import 'interceptor/errors_interceptor.dart';

/// [CustomHttpClient] have different abstract method that are used
/// interact with API.
abstract class CustomHttpClient {
  /// Method to make http GET request
  /// character in the API for some special APIs will have a `\get`
  /// character in the API and structure needs to be changed
  /// for these special APIs in the app.
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool authorization = true,
  });

  /// Method to make http POST request
  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    @required dynamic body,
    bool authorization = true,
  });

  /// Method to make http DELETE request
  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    bool authorization = true,
  });

  /// Method to make http PUT request
  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    @required dynamic body,
    bool authorization = true,
  });

  /// Method to make download the file and save it in local.
  Future<dynamic> download(
    String url,
    String savePath,
    String name,
    ProgressCallback? onReceiveProgress, {
    bool authorization = true,
  });

  /// Method to make upload the file.
  Future<dynamic> upload(
    String url,
    File file, {
    bool authorization = true,
  });
}

/// {@template http_client_impl}
/// This class implement abstract method in [CustomHttpClient] class
/// {@endtemplate}
class HttpClientImpl implements CustomHttpClient {
  late final Dio _dio;

  /// {@macro http_client_impl}
  HttpClientImpl() {
    _dio = diDio;
    // add interceptors
    _dio
      ..interceptors.clear()
      ..interceptors.add(ErrorsInterceptor.instance)
      ..interceptors.add(AuthorizationInterceptor.instance);
    // ..interceptors.add(RetryInterceptor(
    //   // reconect when error
    //   dio: _dio,
    //   retries: 3,
    //   retryDelays: [const Duration(seconds: 2), const Duration(seconds: 4)],
    // ));
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool authorization = true,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers, extra: {
          AppConstants.isAuthenticationKeyInterceptor: authorization,
        }),
      );

      return response.data;
    } on DioException catch (e) {
      AppLogger.instance.e(e.message!);

      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    @required dynamic body,
    bool authorization = true,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers, extra: {
          AppConstants.isAuthenticationKeyInterceptor: authorization,
        }),
      );
      return response.data;
    } on DioException catch (e) {
      AppLogger.instance.e(e.message!);
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    bool authorization = true,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers, extra: {
          AppConstants.isAuthenticationKeyInterceptor: authorization,
        }),
      );
      return response.data;
    } on DioException catch (e) {
      AppLogger.instance.e(e.message!);
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future put(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    @required dynamic body,
    bool authorization = true,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers, extra: {
          AppConstants.isAuthenticationKeyInterceptor: authorization,
        }),
      );
      return response.data;
    } on DioException catch (e) {
      AppLogger.instance.e(e.message!);
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future download(
    String url,
    String savePath,
    String name,
    ProgressCallback? onReceiveProgress, {
    bool authorization = true,
  }) async {
    try {
      await _dio.download(url, savePath,
          onReceiveProgress: onReceiveProgress,
          options: Options(extra: {
            AppConstants.isAuthenticationKeyInterceptor: authorization,
          }));
      return true;
    } on DioException catch (e) {
      AppLogger.instance.e(e.message!);
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future upload(
    String url,
    File file, {
    bool authorization = true,
  }) async {
    try {
      var fileName = file.path.split('/').last;
      var data = FormData.fromMap({
        "files": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      final res = await _dio.post(url,
          data: data,
          options: Options(extra: {
            AppConstants.isAuthenticationKeyInterceptor: authorization,
          }));
      return res.data;
    } on DioException catch (e) {
      AppLogger.instance.e(e.message!);
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
