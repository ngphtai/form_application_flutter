import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;

Future<void> addValueToSheet(PostsModel posts, sheets.SheetsApi sheetsApi,
    String spreadsheetId, String sheetName) async {
  List<dynamic> rowData = [];
  for (var item in posts.itemModels) {
    String result =
        item.result.toString().replaceAll('[', '').replaceAll(']', '');
    if (result == 'null') {
      result = '';
    }
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
