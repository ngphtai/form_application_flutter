import 'package:dsoft_form_application/data/model/mapper_domain.dart';
import 'package:dsoft_form_application/domain/models/item_model.dart';
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
  final List<String>? choices;
  final int? upperBound;
  final String? rightLabel;
  final String? leftLabel;
  final int? lowerBound;
  final bool? includesYear;

  ItemModelDto({
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
        choices: choices,
        upperBound: upperBound,
        rightLabel: rightLabel,
        leftLabel: leftLabel,
        lowerBound: lowerBound,
        includesYear: includesYear);
  }
}
