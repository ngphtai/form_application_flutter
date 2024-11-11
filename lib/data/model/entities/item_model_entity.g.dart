// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemModelEntityAdapter extends TypeAdapter<ItemModelEntity> {
  @override
  final int typeId = 1;

  @override
  ItemModelEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemModelEntity(
      (fields[12] as List?)?.cast<String>(),
      type: fields[0] as String,
      helpText: fields[1] as String,
      title: fields[2] as String,
      index: fields[3] as int,
      id: fields[4] as int,
      isRequired: fields[5] as bool?,
      choices: (fields[6] as List?)?.cast<String>(),
      upperBound: fields[7] as int?,
      rightLabel: fields[8] as String?,
      leftLabel: fields[9] as String?,
      lowerBound: fields[10] as int?,
      includesYear: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemModelEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.helpText)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.index)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.isRequired)
      ..writeByte(6)
      ..write(obj.choices)
      ..writeByte(7)
      ..write(obj.upperBound)
      ..writeByte(8)
      ..write(obj.rightLabel)
      ..writeByte(9)
      ..write(obj.leftLabel)
      ..writeByte(10)
      ..write(obj.lowerBound)
      ..writeByte(11)
      ..write(obj.includesYear)
      ..writeByte(12)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModelEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
