import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsoft_form_application/common/constant/app_errors/api_error.dart';
import 'package:dsoft_form_application/common/constant/app_errors/app_orther_error.dart';
import 'package:either_dart/either.dart';
import '../../common/constant/app_errors/app_error.dart';
import '/common/constant/constants.dart';
import '/common/logger/app_logger.dart';
import '/core/locators/locators.dart';
import '/data/model/DTO/metadata_model_dto.dart';
import '/data/model/DTO/posts_response_model_dto.dart';
import '/data/remote/google_sheet/insert_new_row.dart';
import '/domain/models/post_model.dart';

//example
import 'package:flutter/services.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';

abstract class PostRemoteDataResource {
  Future<List<MetadataModelDTO>> getPosts();
  Future<PostsResponseModelDto> getDetailPost(String index);

  Future<Either<AppError, bool>> saveAnswerToGoogleSheet(PostsModel post);
}

class PostsRemoteDataResourceImpl extends PostRemoteDataResource {
  final customHttpClient = diCustomHttpClient;
  @override
  Future<List<MetadataModelDTO>> getPosts() async {
    try {
      final response = await customHttpClient.get(APIConstants.methodPost);
      final List<MetadataModelDTO> forms =
          (response as List).map((e) => MetadataModelDTO.fromJson(e)).toList();
      //sort by expiry date
      forms.sort((b, a) => a.expireAt.compareTo(b.expireAt));
      return forms;
    } on DioException catch (e) {
      final message = e.response?.data.message;
      AppLogger.instance.e('Error during getForms: $message');
      return Future.error(message);
    }
  }

  @override
  Future<PostsResponseModelDto> getDetailPost(index) async {
    try {
      String url = "${APIConstants.methodPost}/$index";
      var response = await customHttpClient.get(url);
      response = response is String
          ? json.decode(response) as Map<String, dynamic>
          : response;

      final PostsResponseModelDto detailPost =
          PostsResponseModelDto.fromJson(response);
      return detailPost;
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'Unknown error';
      AppLogger.instance.e('Error during detail: $message');
      return Future.error(message);
    }
  }

  @override
  Future<Either<AppError, bool>> saveAnswerToGoogleSheet(
      PostsModel post) async {
    try {
      // Load credentials from assets
      final credentialsJson =
          await rootBundle.loadString(AppConstants.credentials);
      final serviceAccountCredentials =
          ServiceAccountCredentials.fromJson(json.decode(credentialsJson));

      // Define access scopes
      final scopes = [sheets.SheetsApi.spreadsheetsScope];

      // Create authenticated client
      final client =
          await clientViaServiceAccount(serviceAccountCredentials, scopes);
      final sheetsApi = sheets.SheetsApi(client);

      // Validate spreadsheetId
      final spreadsheetId = post.metaData.spreadsheetId;
      if (spreadsheetId.isEmpty) {
        return Left(APIError(message: "Spreadsheet ID is empty."));
      }

      // Add values to the sheet
      await addValueToSheet(
          post, sheetsApi, spreadsheetId, "Câu trả lời biểu mẫu 1");

      // Close client
      client.close();
      return const Right(true);
    } on sheets.DetailedApiRequestError catch (e) {
      // Handle Google Sheets-specific errors
      return Left(APIError(message: e.message ?? "An error occurred."));
    } catch (e) {
      // Handle any other generic errors
      return Left(
          AppOtherError(messageError: e.toString(), exception: e as Exception));
    }
  }
}
