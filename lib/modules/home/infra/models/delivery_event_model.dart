import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_event.dart';
import 'package:hive/hive.dart';

part 'delivery_event_model.g.dart';

@HiveType(typeId: DeliveryEventModel.typeId)
class DeliveryEventModel extends HiveObject {
  static const typeId = 1;

  @HiveField(0)
  final String status;
  @HiveField(1)
  final String data;
  @HiveField(2)
  final String hora;
  @HiveField(3)
  final String? origem;
  @HiveField(4)
  final String? destino;
  @HiveField(5)
  final String? local;

  DeliveryEventModel({
    required this.status,
    required this.data,
    required this.hora,
    this.origem,
    this.destino,
    this.local,
  });

  factory DeliveryEventModel.fromDomain(DeliveryEvent event) {
    return DeliveryEventModel(
      status: event.status,
      data: event.data,
      hora: event.hora,
      destino: event.destino,
      local: event.local,
      origem: event.origem,
    );
  }

  DeliveryEvent mapToDomain() => DeliveryEvent(
        data: data,
        hora: hora,
        status: status,
        destino: destino,
        local: local,
        origem: origem,
      );
}
