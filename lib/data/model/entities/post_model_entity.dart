import 'package:dsoft_form_application/data/model/entities/item_model_entity.dart';
import 'package:dsoft_form_application/data/model/entities/metadata_model_entity.dart';
import 'package:dsoft_form_application/data/model/mapper_domain.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class PostModelEntity extends MapperDomain<PostsModel> {
  final MetadataModelEntity metaData;
  final List<ItemModelEntity> items;

  PostModelEntity({required this.items, required this.metaData});

  @override
  PostsModel toDomain() {
    return PostsModel(
        itemModels: items.map((item) => item.toDomain()).toList(),
        metaData: metaData.toDomain());
  }
}
