import 'package:dsoft_form_application/data/model/mapper_domain.dart';
import 'package:dsoft_form_application/domain/models/meta_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata_model_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class MetadataModelDTO extends MapperDomain<MetaDataModel> {
  final String id;
  final bool isFilled;
  final String title;
  final String imageURLDescription;
  final String description;
  final String publishedUrl;
  final List<String> editorEmails;
  final int count;
  final String confirmationMessage;
  final String customClosedFormMessage;

  MetadataModelDTO({
    required this.id,
    required this.isFilled,
    required this.title,
    required this.imageURLDescription,
    required this.description,
    required this.publishedUrl,
    required this.editorEmails,
    required this.count,
    required this.confirmationMessage,
    required this.customClosedFormMessage,
  });

  factory MetadataModelDTO.fromJson(Map<String, dynamic> json) =>
      _$MetadataModelDTOFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataModelDTOToJson(this);

  @override
  MetaDataModel toDomain() {
    return MetaDataModel(
        id: id,
        isFilled: isFilled,
        title: title,
        imageURLDescription: imageURLDescription,
        description: description,
        publishedUrl: publishedUrl,
        editorEmails: editorEmails,
        count: count,
        confirmationMessage: confirmationMessage,
        customClosedFormMessage: customClosedFormMessage);
  }
}
