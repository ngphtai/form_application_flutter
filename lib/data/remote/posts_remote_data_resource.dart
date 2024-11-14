import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsoft_form_application/common/constant/constants.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/data/model/DTO/posts_response_model_dto.dart';
import 'package:dsoft_form_application/data/remote/google_sheet/insert_new_row.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';

//example
import 'package:flutter/services.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';

import 'google_sheet/create_new_sheet.dart';

abstract class PostRemoteDataResource {
  Future<List<PostsResponseModelDto>> getPosts();
  Future<PostsResponseModelDto> getDetailPost(int index);

  Future<bool> saveAnswerToGoogleSheet(PostsModel post);
}

class PostsRemoteDataResourceImpl extends PostRemoteDataResource {
  final customHttpClient = diCustomHttpClient;
  @override
  Future<List<PostsResponseModelDto>> getPosts() async {
    try {
      final response = await customHttpClient.get(APIConstants.methodPost);
      final List<PostsResponseModelDto> forms = (response as List)
          .map((e) => PostsResponseModelDto.fromJson(e))
          .toList();
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
      String url = "${APIConstants.methodPost}/${index}";
      var response = await customHttpClient.get(url);

      // var response = response.data;

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
  Future<bool> saveAnswerToGoogleSheet(PostsModel post) async {
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

      const spreadsheetId = AppConstants.spreadsheetId;

      // Format sheet name to be valid
      String sheetName = post.metaData.id.replaceAll(' ', '-');

      // Check if spreadsheet exists
      final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);

      if (!spreadsheet.sheets!
          .any((sheet) => sheet.properties!.title == sheetName)) {
        // Create new sheet
        await createNewSheet(sheetName, sheetsApi, spreadsheetId, post);
        await addValueToSheet(post, sheetsApi, spreadsheetId, sheetName);
      } else {
        await addValueToSheet(post, sheetsApi, spreadsheetId, sheetName);
      }

      // Close client
      client.close();
      return true;
    } catch (e) {
      AppLogger.instance.e(e.toString());
      return false;
    }
  }
}
