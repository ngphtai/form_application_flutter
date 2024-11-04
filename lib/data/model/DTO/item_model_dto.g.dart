// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModelDto _$ItemModelDtoFromJson(Map<String, dynamic> json) => ItemModelDto(
      type: json['type'] as String,
      helpText: json['helpText'] as String,
      title: json['title'] as String,
      index: (json['index'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      isRequired: json['isRequired'] as bool?,
      choices:
          (json['choices'] as List<dynamic>?)?.map((e) => e as String).toList(),
      upperBound: (json['upperBound'] as num?)?.toInt(),
      rightLabel: json['rightLabel'] as String?,
      leftLabel: json['leftLabel'] as String?,
      lowerBound: (json['lowerBound'] as num?)?.toInt(),
      includesYear: json['includesYear'] as bool?,
    );

Map<String, dynamic> _$ItemModelDtoToJson(ItemModelDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'helpText': instance.helpText,
      'title': instance.title,
      'index': instance.index,
      'id': instance.id,
      'isRequired': instance.isRequired,
      'choices': instance.choices,
      'upperBound': instance.upperBound,
      'rightLabel': instance.rightLabel,
      'leftLabel': instance.leftLabel,
      'lowerBound': instance.lowerBound,
      'includesYear': instance.includesYear,
    };
