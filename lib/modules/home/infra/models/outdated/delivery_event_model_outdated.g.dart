// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_event_model_outdated.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryEventModelOutdatedAdapter
    extends TypeAdapter<DeliveryEventModelOutdated> {
  @override
  final int typeId = 1;

  @override
  DeliveryEventModelOutdated read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryEventModelOutdated(
      status: fields[0] as String,
      data: fields[1] as String,
      hora: fields[2] as String,
      origem: fields[3] as String?,
      destino: fields[4] as String?,
      local: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryEventModelOutdated obj) {
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
      other is DeliveryEventModelOutdatedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
