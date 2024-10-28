import 'package:dsoft_form_application/data/model/entities/post_entity.dart';

class PostModel {
  late final int id;
  late final String title;
  late final String body;

  PostModel({required this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  @override
  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      body: body,
    );
  }
}
