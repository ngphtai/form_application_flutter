import 'package:dsoft_form_application/data/model/mapper_domain.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/models/meta_data_model.dart';

@HiveType(typeId: 0)
class MetadataModelEntity extends MapperDomain<MetaDataModel> {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final bool isFilled;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String imageURLDescription;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String publishedUrl;

  @HiveField(6)
  final List<String> editorEmails;

  @HiveField(7)
  final int count;

  @HiveField(8)
  final String confirmationMessage;

  @HiveField(9)
  final String customClosedFormMessage;

  MetadataModelEntity(
      {required this.id,
      required this.isFilled,
      required this.title,
      required this.imageURLDescription,
      required this.description,
      required this.publishedUrl,
      required this.editorEmails,
      required this.count,
      required this.confirmationMessage,
      required this.customClosedFormMessage});

  @override
  MetaDataModel toDomain() {
    return MetaDataModel(
        id: id,
        isFilled: isFilled,
        title: title,
        imageURLDescription: imageURLDescription,
        description: description,
        publishedUrl: publishedUrl,
        editorEmails: editorEmails,
        count: count,
        confirmationMessage: confirmationMessage,
        customClosedFormMessage: customClosedFormMessage);
  }
}
