// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryEventModelAdapter extends TypeAdapter<DeliveryEventModel> {
  @override
  final int typeId = 1;

  @override
  DeliveryEventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryEventModel(
      status: fields[0] as String,
      data: fields[1] as String,
      hora: fields[2] as String,
      origem: fields[3] as String?,
      destino: fields[4] as String?,
      local: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryEventModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.hora)
      ..writeByte(3)
      ..write(obj.origem)
      ..writeByte(4)
      ..write(obj.destino)
      ..writeByte(5)
      ..write(obj.local);
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
