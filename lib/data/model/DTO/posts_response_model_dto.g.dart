// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_response_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsResponseModelDto _$PostsResponseModelDtoFromJson(
        Map<String, dynamic> json) =>
    PostsResponseModelDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemModelDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata:
          MetadataModelDTO.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostsResponseModelDtoToJson(
        PostsResponseModelDto instance) =>
    <String, dynamic>{
      'metadata': instance.metadata.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
