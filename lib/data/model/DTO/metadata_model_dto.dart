import '/data/model/mapper_domain.dart';
import '/domain/models/meta_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata_model_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class MetadataModelDTO extends MapperDomain<MetaDataModel> {
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

  MetadataModelDTO({
    required this.id,
    required this.enable,
    required this.title,
    required this.description,
    required this.publishedUrl,
    required this.editorEmails,
    required this.count,
    required this.confirmationMessage,
    required this.customClosedFormMessage,
    required this.spreadsheetId,
    required this.createAt,
    required this.expireAt,
  });

  factory MetadataModelDTO.fromJson(Map<String, dynamic> json) =>
      _$MetadataModelDTOFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataModelDTOToJson(this);

  @override
  MetaDataModel toDomain() {
    return MetaDataModel(
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
        expireAt: expireAt);
  }
}
