// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelEntityAdapter extends TypeAdapter<PostModelEntity> {
  @override
  final int typeId = 2;

  @override
  PostModelEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModelEntity(
      items: (fields[1] as List).cast<ItemModelEntity>(),
      metaData: fields[0] as MetadataModelEntity,
    );
  }

  @override
  void write(BinaryWriter writer, PostModelEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.metaData)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
