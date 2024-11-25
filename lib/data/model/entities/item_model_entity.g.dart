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
      type: fields[0] as String,
      helpText: fields[1] as String,
      title: fields[2] as String,
      index: fields[3] as int,
      id: fields[4] as int,
      isRequired: fields[5] as bool?,
      choices: (fields[7] as List?)?.cast<String>(),
      upperBound: fields[12] as int?,
      rightLabel: fields[14] as String?,
      leftLabel: fields[15] as String?,
      lowerBound: fields[13] as int?,
      includesYear: fields[11] as bool?,
      result: (fields[16] as List?)?.cast<String>(),
      points: fields[6] as int?,
      hasOtherOption: fields[8] as bool?,
      ratingIcon: fields[9] as String?,
      ratingScaleLevel: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemModelEntity obj) {
    writer
      ..writeByte(17)
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
      ..write(obj.points)
      ..writeByte(7)
      ..write(obj.choices)
      ..writeByte(8)
      ..write(obj.hasOtherOption)
      ..writeByte(9)
      ..write(obj.ratingIcon)
      ..writeByte(10)
      ..write(obj.ratingScaleLevel)
      ..writeByte(11)
      ..write(obj.includesYear)
      ..writeByte(12)
      ..write(obj.upperBound)
      ..writeByte(13)
      ..write(obj.lowerBound)
      ..writeByte(14)
      ..write(obj.rightLabel)
      ..writeByte(15)
      ..write(obj.leftLabel)
      ..writeByte(16)
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
