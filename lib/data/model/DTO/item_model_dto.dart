import '/data/model/mapper_domain.dart';
import '/domain/models/item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model_dto.g.dart';

@JsonSerializable()
class ItemModelDto extends MapperDomain<ItemModel> {
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

  ItemModelDto({
    required this.type,
    required this.helpText,
    required this.title,
    required this.index,
    required this.id,
    this.isRequired,
    this.points,
    this.choices,
    this.hasOtherOption,
    this.ratingIcon,
    this.ratingScaleLevel,
    this.includesYear,
    this.upperBound,
    this.lowerBound,
    this.rightLabel,
    this.leftLabel,
  });

  factory ItemModelDto.fromJson(Map<String, dynamic> json) =>
      _$ItemModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelDtoToJson(this);

  @override
  ItemModel toDomain() {
    return ItemModel(
      type: type,
      helpText: helpText,
      title: title,
      index: index,
      id: id,
      isRequired: isRequired,
      points: points,
      choices: choices,
      hasOtherOption: hasOtherOption,
      ratingIcon: ratingIcon,
      ratingScaleLevel: ratingScaleLevel,
      includesYear: includesYear,
      upperBound: upperBound,
      lowerBound: lowerBound,
      rightLabel: rightLabel,
      leftLabel: leftLabel,
    );
  }
}
