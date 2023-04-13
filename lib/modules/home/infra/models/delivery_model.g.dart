// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryModelAdapter extends TypeAdapter<DeliveryModel> {
  @override
  final int typeId = 0;

  @override
  DeliveryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryModel(
      code: fields[1] as String,
      events: (fields[3] as List).cast<DeliveryEventModel>(),
      expectedDate: fields[5] as DateTime,
      title: fields[2] as String,
      deliveryListId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(5)
      ..write(obj.expectedDate)
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
      other is DeliveryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
