import 'package:dsoft_form_application/data/model/DTO/item_model_dto.dart';
import 'package:dsoft_form_application/data/model/mapper_domain.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dsoft_form_application/data/model/DTO/metadata_model_dto.dart';

part 'posts_response_model_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PostsResponseModelDto extends MapperDomain<PostsModel> {
  final MetadataModelDTO metadata;
  final List<ItemModelDto> items;
  PostsResponseModelDto({required this.items, required this.metadata});

  factory PostsResponseModelDto.fromJson(Map<String, dynamic> json) =>
      _$PostsResponseModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostsResponseModelDtoToJson(this);

  @override
  PostsModel toDomain() {
    return PostsModel(
        metaData: metadata.toDomain(),
        itemModels: items.map((item) => item.toDomain()).toList());
  }
}
