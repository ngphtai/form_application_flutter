// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataModelDTO _$MetadataModelDTOFromJson(Map<String, dynamic> json) =>
    MetadataModelDTO(
      id: json['id'] as String,
      isFilled: json['isFilled'] as bool,
      title: json['title'] as String,
      imageURLDescription: json['imageURLDescription'] as String,
      description: json['description'] as String,
      publishedUrl: json['publishedUrl'] as String,
      editorEmails: (json['editorEmails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      count: (json['count'] as num).toInt(),
      confirmationMessage: json['confirmationMessage'] as String,
      customClosedFormMessage: json['customClosedFormMessage'] as String,
    );

Map<String, dynamic> _$MetadataModelDTOToJson(MetadataModelDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isFilled': instance.isFilled,
      'title': instance.title,
      'imageURLDescription': instance.imageURLDescription,
      'description': instance.description,
      'publishedUrl': instance.publishedUrl,
      'editorEmails': instance.editorEmails,
      'count': instance.count,
      'confirmationMessage': instance.confirmationMessage,
      'customClosedFormMessage': instance.customClosedFormMessage,
    };
