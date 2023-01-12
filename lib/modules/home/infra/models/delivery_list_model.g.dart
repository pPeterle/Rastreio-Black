// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryListModelAdapter extends TypeAdapter<DeliveryListModel> {
  @override
  final int typeId = 2;

  @override
  DeliveryListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryListModel(
      uuid: fields[1] as String,
      title: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryListModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.uuid)
      ..writeByte(2)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
