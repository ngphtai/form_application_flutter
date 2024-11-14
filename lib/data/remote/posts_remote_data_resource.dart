import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsoft_form_application/common/constant/constants.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/data/model/DTO/posts_response_model_dto.dart';

import '../model/entities/post_model_entity.dart';
import 'package:dsoft_form_application/common/extensions/remove_bracket.dart';
//example
import 'package:flutter/services.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';

abstract class PostRemoteDataResource {
  Future<List<PostsResponseModelDto>> getPosts();
  Future<PostsResponseModelDto> getDetailPost(int index);

  Future<void> insertValueToGoogleSheet(PostModelEntity postEntity);
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
  Future<void> insertValueToGoogleSheet(PostModelEntity postEntity) async {
    try {
      // Load credentials from assets
      final credentialsJson =
          await rootBundle.loadString('assets/credentials.json');
      final serviceAccountCredentials =
          ServiceAccountCredentials.fromJson(json.decode(credentialsJson));

      // Define access scopes
      final scopes = [sheets.SheetsApi.spreadsheetsScope];

      // Create authenticated client
      final client =
          await clientViaServiceAccount(serviceAccountCredentials, scopes);
      final sheetsApi = sheets.SheetsApi(client);

      const spreadsheetId = '1dRDA_ovwIfmodIEp8gKLeRMQSE73g9_ndLpmSmvD_FQ';

      // Format sheet name to be valid
      String sheetName = postEntity.metaData.id.replaceAll(' ', '-');

      // Check if spreadsheet exists
      final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);
      if (!spreadsheet.sheets!
          .any((sheet) => sheet.properties!.title == sheetName)) {
        // Create new sheet
        final addSheetRequest = sheets.AddSheetRequest(
          properties: sheets.SheetProperties(title: sheetName),
        );
        await sheetsApi.spreadsheets.batchUpdate(
          sheets.BatchUpdateSpreadsheetRequest(requests: [
            sheets.Request(addSheet: addSheetRequest),
          ]),
          spreadsheetId,
        );

        // Prepare column titles from postEntity.items
        List<String> columnTitles = postEntity.items
            .map((item) => "${item.index} ${item.title}")
            .toList();
        columnTitles.addAll(['Creation Time', 'Update Time']);

        // Insert column titles as the first row
        final valueRange = sheets.ValueRange.fromJson({
          'values': [columnTitles]
        });
        await sheetsApi.spreadsheets.values.append(
          valueRange,
          spreadsheetId,
          sheetName,
          valueInputOption: 'USER_ENTERED',
          insertDataOption: 'INSERT_ROWS',
        );
        await addValueToSheet(postEntity, sheetsApi, spreadsheetId, sheetName);
      } else {
        await addValueToSheet(postEntity, sheetsApi, spreadsheetId, sheetName);
      }

      // Close client
      client.close();
    } catch (e) {
      AppLogger.instance.e(e.toString());
    }
  }

  Future<void> addValueToSheet(
      PostModelEntity postEntity,
      sheets.SheetsApi sheetsApi,
      String spreadsheetId,
      String sheetName) async {
    List<dynamic> rowData = [];
    for (var item in postEntity.items) {
      String result =
          item.result!.toString().replaceAll('[', '').replaceAll(']', '');
      rowData.add(result);
    }

    // Add current time
    DateTime now = DateTime.now();
    rowData.add(now.toIso8601String());

    // Create ValueRange object
    final valueRange = sheets.ValueRange.fromJson({
      'values': [rowData]
    });

    // Append data to Google Sheets
    await sheetsApi.spreadsheets.values.append(
      valueRange,
      spreadsheetId,
      sheetName,
      valueInputOption: 'USER_ENTERED',
      insertDataOption: 'INSERT_ROWS',
    );
  }
}
