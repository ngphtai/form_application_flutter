import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class PostEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;

  PostEntity({
    required this.id,
    required this.title,
    required this.body,
  });
  @override
  PostModel toDomain() {
    return PostModel(id: id, title: title, body: body);
  }
}
