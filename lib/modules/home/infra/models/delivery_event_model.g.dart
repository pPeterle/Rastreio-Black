// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryEventModelAdapter extends TypeAdapter<DeliveryEventModel> {
  @override
  final int typeId = 5;

  @override
  DeliveryEventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryEventModel(
      status: fields[0] as String,
      date: fields[1] as DateTime,
      unity: fields[5] as DeliveryUnitModel,
      destiny: fields[4] as DeliveryUnitModel?,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryEventModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.destiny)
      ..writeByte(5)
      ..write(obj.unity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryEventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
