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
      points: (json['points'] as num?)?.toInt(),
      choices:
          (json['choices'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hasOtherOption: json['hasOtherOption'] as bool?,
      ratingIcon: json['ratingIcon'] as String?,
      ratingScaleLevel: (json['ratingScaleLevel'] as num?)?.toInt(),
      includesYear: json['includesYear'] as bool?,
      upperBound: (json['upperBound'] as num?)?.toInt(),
      lowerBound: (json['lowerBound'] as num?)?.toInt(),
      rightLabel: json['rightLabel'] as String?,
      leftLabel: json['leftLabel'] as String?,
    )..result =
        (json['result'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$ItemModelDtoToJson(ItemModelDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'helpText': instance.helpText,
      'title': instance.title,
      'index': instance.index,
      'id': instance.id,
      'isRequired': instance.isRequired,
      'points': instance.points,
      'choices': instance.choices,
      'hasOtherOption': instance.hasOtherOption,
      'ratingIcon': instance.ratingIcon,
      'ratingScaleLevel': instance.ratingScaleLevel,
      'includesYear': instance.includesYear,
      'upperBound': instance.upperBound,
      'lowerBound': instance.lowerBound,
      'rightLabel': instance.rightLabel,
      'leftLabel': instance.leftLabel,
      'result': instance.result,
    };
