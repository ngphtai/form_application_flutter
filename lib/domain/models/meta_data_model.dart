import '/data/model/entities/metadata_model_entity.dart';
import '/domain/models/mapper_entity.dart';

class MetaDataModel extends MapperEntity<MetadataModelEntity> {
  final String id;
  final bool enable;
  final String title;
  final String description;
  final String publishedUrl;
  final List<String> editorEmails;
  final int count;
  final String confirmationMessage;
  final String customClosedFormMessage;
  final String spreadsheetId;
  final DateTime createAt;
  final DateTime expireAt;

  MetaDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.publishedUrl,
    required this.editorEmails,
    required this.count,
    required this.confirmationMessage,
    required this.customClosedFormMessage,
    required this.enable,
    required this.spreadsheetId,
    required this.createAt,
    required this.expireAt,
  });

  factory MetaDataModel.fromJson(Map<String, dynamic> json) {
    return MetaDataModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        publishedUrl: json['publishedUrl'],
        editorEmails: json['editorEmails'],
        count: json['count'],
        confirmationMessage: json['confirmationMessage'],
        customClosedFormMessage: json['customClosedFormMessage'],
        spreadsheetId: json['spreadsheetId'],
        enable: json['enable'],
        createAt: DateTime.parse(json['createAt']),
        expireAt: DateTime.parse(json['expireAt']));
  }

  @override
  MetadataModelEntity toEntity() {
    return MetadataModelEntity(
        id: id,
        title: title,
        description: description,
        publishedUrl: publishedUrl,
        editorEmails: editorEmails,
        count: count,
        confirmationMessage: confirmationMessage,
        customClosedFormMessage: customClosedFormMessage,
        enable: enable,
        spreadsheetId: spreadsheetId,
        createAt: createAt,
        expireAt: expireAt,
        updateAt: null);
  }
}
