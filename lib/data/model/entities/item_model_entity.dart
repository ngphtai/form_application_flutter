import 'package:dsoft_form_application/data/model/mapper_domain.dart';
import 'package:dsoft_form_application/domain/models/item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'item_model_entity.g.dart';

@HiveType(typeId: 1)
class ItemModelEntity extends MapperDomain<ItemModel> {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final String helpText;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final int index;
  @HiveField(4)
  final int id;
  @HiveField(5)
  final bool? isRequired;
  @HiveField(6)
  final List<String>? choices;
  @HiveField(7)
  final int? upperBound;
  @HiveField(8)
  final String? rightLabel;
  @HiveField(9)
  final String? leftLabel;
  @HiveField(10)
  final int? lowerBound;
  @HiveField(11)
  final bool? includesYear;
  //propety to save result
  @HiveField(12)
  late List<String>? result;

  ItemModelEntity(this.result,
      {required this.type,
      required this.helpText,
      required this.title,
      required this.index,
      required this.id,
      required this.isRequired,
      required this.choices,
      required this.upperBound,
      required this.rightLabel,
      required this.leftLabel,
      required this.lowerBound,
      required this.includesYear});

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
      includesYear: includesYear,
    );
  }
}
