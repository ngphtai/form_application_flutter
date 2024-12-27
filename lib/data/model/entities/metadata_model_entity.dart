import '/data/model/mapper_domain.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/models/meta_data_model.dart';

part 'metadata_model_entity.g.dart';

@HiveType(typeId: 0)
class MetadataModelEntity extends MapperDomain<MetaDataModel> {
  @HiveField(0)
  late String id;
  @HiveField(1)
  final bool enable;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String publishedUrl;
  @HiveField(5)
  final List<String> editorEmails;
  @HiveField(6)
  final int count;
  @HiveField(7)
  final String confirmationMessage;
  @HiveField(8)
  final String customClosedFormMessage;
  @HiveField(9)
  final String spreadsheetId;
  @HiveField(10)
  final DateTime createAt;
  @HiveField(11)
  final DateTime expireAt;
  @HiveField(12)
  late DateTime? updateAt;

  MetadataModelEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.publishedUrl,
    required this.editorEmails,
    required this.count,
    required this.confirmationMessage,
    required this.customClosedFormMessage,
    required this.enable,
    required this.spreadsheetId,
    required this.createAt,
    required this.expireAt,
    required this.updateAt,
  });

  @override
  MetaDataModel toDomain() {
    return MetaDataModel(
        id: id,
        title: title,
        description: description,
        publishedUrl: publishedUrl,
        editorEmails: editorEmails,
        count: count,
        confirmationMessage: confirmationMessage,
        customClosedFormMessage: customClosedFormMessage,
        enable: enable,
        spreadsheetId: spreadsheetId,
        createAt: createAt,
        expireAt: expireAt);
  }
}
