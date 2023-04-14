// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_model_outdated.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryModelOutdatedAdapter extends TypeAdapter<DeliveryModelOutdated> {
  @override
  final int typeId = 0;

  @override
  DeliveryModelOutdated read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryModelOutdated(
      code: fields[1] as String,
      events: (fields[3] as List).cast<DeliveryEventModel>(),
      title: fields[2] as String,
      deliveryListId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryModelOutdated obj) {
    writer
      ..writeByte(4)
      ..writeByte(4)
      ..write(obj.deliveryListId)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.events);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryModelOutdatedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
