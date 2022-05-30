import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_events.dart';
import 'package:hive/hive.dart';

part 'delivery_events_model.g.dart';

@HiveType(typeId: 1)
class DeliveryEventsModel {
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

  const DeliveryEventsModel({
    required this.status,
    required this.data,
    required this.hora,
    this.origem,
    this.destino,
    this.local,
  });

  DeliveryEvents mapToDomain() => DeliveryEvents(
        data: data,
        hora: hora,
        status: status,
        destino: destino,
        local: local,
        origem: origem,
      );
}
