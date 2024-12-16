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
      title: fields[2] as String,
      description: fields[3] as String,
      publishedUrl: fields[4] as String,
      editorEmails: (fields[5] as List).cast<String>(),
      count: fields[6] as int,
      confirmationMessage: fields[7] as String,
      customClosedFormMessage: fields[8] as String,
      enable: fields[1] as bool,
      spreadsheetId: fields[9] as String,
      createAt: fields[10] as DateTime,
      expireAt: fields[11] as DateTime,
      updateAt: fields[12] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MetadataModelEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.enable)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.publishedUrl)
      ..writeByte(5)
      ..write(obj.editorEmails)
      ..writeByte(6)
      ..write(obj.count)
      ..writeByte(7)
      ..write(obj.confirmationMessage)
      ..writeByte(8)
      ..write(obj.customClosedFormMessage)
      ..writeByte(9)
      ..write(obj.spreadsheetId)
      ..writeByte(10)
      ..write(obj.createAt)
      ..writeByte(11)
      ..write(obj.expireAt)
      ..writeByte(12)
      ..write(obj.updateAt);
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
