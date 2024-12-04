import '/domain/models/post_model.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;

Future<void> createNewSheet(
  String sheetName,
  sheets.SheetsApi sheetsApi,
  String spreadsheetId,
  PostsModel post,
) async {
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
  // Add title to sheet
  await addTitlePost(post, sheetsApi, spreadsheetId, sheetName);

  // Prepare column titles from postEntity.items
  List<String> columnTitles =
      post.itemModels.map((item) => "${item.index} ${item.title}").toList();
  //add creation and update time
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
}

Future<sheets.ValueRange> addTitlePost(PostsModel post,
    sheets.SheetsApi sheetsApi, String spreadsheetId, String sheetName) async {
  List<String> title = [];
  title.add(post.metaData.id);
  title.add(post.metaData.title);
  final valueRange = sheets.ValueRange.fromJson({
    'values': [title]
  });
  await sheetsApi.spreadsheets.values.append(
    valueRange,
    spreadsheetId,
    sheetName,
    valueInputOption: 'USER_ENTERED',
    insertDataOption: 'INSERT_ROWS',
  );
  return valueRange;
}
