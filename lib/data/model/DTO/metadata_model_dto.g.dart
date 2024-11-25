// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataModelDTO _$MetadataModelDTOFromJson(Map<String, dynamic> json) =>
    MetadataModelDTO(
      id: json['id'] as String,
      enable: json['enable'] as bool,
      title: json['title'] as String,
      description: json['description'] as String,
      publishedUrl: json['publishedUrl'] as String,
      editorEmails: (json['editorEmails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      count: (json['count'] as num).toInt(),
      confirmationMessage: json['confirmationMessage'] as String,
      customClosedFormMessage: json['customClosedFormMessage'] as String,
      spreadsheetId: json['spreadsheetId'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      expireAt: DateTime.parse(json['expireAt'] as String),
    );

Map<String, dynamic> _$MetadataModelDTOToJson(MetadataModelDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enable': instance.enable,
      'title': instance.title,
      'description': instance.description,
      'publishedUrl': instance.publishedUrl,
      'editorEmails': instance.editorEmails,
      'count': instance.count,
      'confirmationMessage': instance.confirmationMessage,
      'customClosedFormMessage': instance.customClosedFormMessage,
      'spreadsheetId': instance.spreadsheetId,
      'createAt': instance.createAt.toIso8601String(),
      'expireAt': instance.expireAt.toIso8601String(),
    };
