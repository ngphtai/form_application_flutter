import 'package:dsoft_form_application/domain/models/item_model.dart';
import 'package:dsoft_form_application/domain/models/meta_data_model.dart';

class PostsModel {
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
}
