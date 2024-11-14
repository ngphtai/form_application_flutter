import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';

Future<void> createOrder() async {
  String orderId = '123';
  String orderStatus = '0';
// Đọc thông tin xác thực từ assets
  final credentialsJson =
      await rootBundle.loadString('assets/credentials.json');
  final accountCredentials = ServiceAccountCredentials.fromJson(
    json.decode(credentialsJson),
  );

// Phạm vi quyền truy cập
  final scopes = [sheets.SheetsApi.spreadsheetsScope];

// Tạo client xác thực
  final client = await clientViaServiceAccount(accountCredentials, scopes);
  final sheetsApi = sheets.SheetsApi(client);

  final spreadsheetId =
      '1dRDA_ovwIfmodIEp8gKLeRMQSE73g9_ndLpmSmvD_FQ'; // Thay bang ID của Google Sheets
  final sheetName = 'orders';

// Lẩy thời gian hiện tại
  final now = DateTime.now().toIso8601String();

// Chuẩn bị dữ liệu để ghi vào Google Sheets
  List<dynamic> row = [];

// Thêm orderId va orderStatus
  row.add(orderId);
  row.add(orderStatus);

// Thêm thời gian tạo và cập nhật
  row.add(now); // create_time
  row.add(now); // update_time

// Tạo đối tượng ValueRange
  final valueRange = sheets.ValueRange.fromJson({
    'values': [row],
  });
// Append dữ liệu vào Google Sheets
  await sheetsApi.spreadsheets.values.append(
    valueRange,
    spreadsheetId,
    sheetName,
    valueInputOption: 'USER_ENTERED',
    insertDataOption: 'INSERT_ROWS',
  );
// Đóng client
  client.close();
}

// run main function
