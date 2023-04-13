// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_unit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryUnitModelAdapter extends TypeAdapter<DeliveryUnitModel> {
  @override
  final int typeId = 3;

  @override
  DeliveryUnitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryUnitModel(
      name: fields[0] as String,
      city: fields[1] as String,
      uf: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryUnitModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.uf);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryUnitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
