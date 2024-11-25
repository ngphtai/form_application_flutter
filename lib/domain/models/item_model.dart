import 'package:dsoft_form_application/data/model/entities/item_model_entity.dart';
import 'package:dsoft_form_application/domain/models/mapper_entity.dart';

class ItemModel extends MapperEntity<ItemModelEntity> {
  final String type;
  final String helpText;
  final String title;
  final int index;
  final int id;
  final bool? isRequired;
  final int? points;
  final List<String>? choices;
  final bool? hasOtherOption;
  final String? ratingIcon;
  final int? ratingScaleLevel;
  final bool? includesYear;
  final int? upperBound;
  final int? lowerBound;
  final String? rightLabel;
  final String? leftLabel;
  late List<String>? result;
  ItemModel({
    required this.type,
    required this.helpText,
    required this.title,
    required this.index,
    required this.id,
    this.isRequired,
    this.choices,
    this.upperBound,
    this.rightLabel,
    this.leftLabel,
    this.lowerBound,
    this.includesYear,
    this.result,
    this.points,
    this.hasOtherOption,
    this.ratingIcon,
    this.ratingScaleLevel,
  });

  factory ItemModel.fromJSon(Map<String, dynamic> json) {
    return ItemModel(
        type: json['type'],
        helpText: json['helpText'],
        title: json['title'],
        index: json['index'],
        id: json['id'],
        isRequired: json['isRequired'],
        choices: json['choices'],
        upperBound: json['upperBound'],
        rightLabel: json['rightLabel'],
        leftLabel: json['leftLabel'],
        lowerBound: json['lowerBound'],
        includesYear: json['includesYear'],
        result: json['result'],
        points: json['points'],
        hasOtherOption: json['hasOtherOption'],
        ratingIcon: json['ratingIcon'],
        ratingScaleLevel: json['ratingScaleLevel']);
  }

  @override
  ItemModelEntity toEntity() {
    return ItemModelEntity(
      points: points,
      hasOtherOption: hasOtherOption,
      ratingIcon: ratingIcon,
      ratingScaleLevel: ratingScaleLevel,
      result: result,
      type: type,
      helpText: helpText,
      title: title,
      index: index,
      id: id,
      isRequired: isRequired,
      choices: choices,
      upperBound: upperBound,
      rightLabel: rightLabel,
      leftLabel: leftLabel,
      lowerBound: lowerBound,
      includesYear: includesYear,
    );
  }
}
