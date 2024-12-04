import '/data/model/entities/item_model_entity.dart';
import '/data/model/entities/metadata_model_entity.dart';
import '/data/model/mapper_domain.dart';
import '/domain/models/post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'post_model_entity.g.dart';

@HiveType(typeId: 2)
class PostModelEntity extends MapperDomain<PostsModel> {
  @HiveField(0)
  final MetadataModelEntity metaData;

  @HiveField(1)
  final List<ItemModelEntity> items;

  PostModelEntity({required this.items, required this.metaData});

  @override
  PostsModel toDomain() {
    return PostsModel(
        itemModels: items.map((item) => item.toDomain()).toList(),
        metaData: metaData.toDomain());
  }
}
