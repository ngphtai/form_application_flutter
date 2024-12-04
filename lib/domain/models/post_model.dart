import '/data/model/entities/post_model_entity.dart';
import '/domain/models/item_model.dart';
import '/domain/models/mapper_entity.dart';
import '/domain/models/meta_data_model.dart';

class PostsModel extends MapperEntity<PostModelEntity> {
  final MetaDataModel metaData;
  final List<ItemModel> itemModels;

  PostsModel({required this.metaData, required this.itemModels});

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      metaData: MetaDataModel.fromJson(json['metadata']),
      itemModels: (json['items'] as List)
          .map((item) => ItemModel.fromJSon(json['items']))
          .toList(),
    );
  }

  @override
  PostModelEntity toEntity() {
    return PostModelEntity(
      metaData: metaData.toEntity(),
      items: itemModels.map((item) => item.toEntity()).toList(),
    );
  }
}
