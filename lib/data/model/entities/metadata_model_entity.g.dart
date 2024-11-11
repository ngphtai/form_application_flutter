// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_model_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetadataModelEntityAdapter extends TypeAdapter<MetadataModelEntity> {
  @override
  final int typeId = 0;

  @override
  MetadataModelEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetadataModelEntity(
      id: fields[0] as String,
      isFilled: fields[1] as bool,
      title: fields[2] as String,
      imageURLDescription: fields[3] as String,
      description: fields[4] as String,
      publishedUrl: fields[5] as String,
      editorEmails: (fields[6] as List).cast<String>(),
      count: fields[7] as int,
      confirmationMessage: fields[8] as String,
      customClosedFormMessage: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MetadataModelEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isFilled)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.imageURLDescription)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.publishedUrl)
      ..writeByte(6)
      ..write(obj.editorEmails)
      ..writeByte(7)
      ..write(obj.count)
      ..writeByte(8)
      ..write(obj.confirmationMessage)
      ..writeByte(9)
      ..write(obj.customClosedFormMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetadataModelEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
