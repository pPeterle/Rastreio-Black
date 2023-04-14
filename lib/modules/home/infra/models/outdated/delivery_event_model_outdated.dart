import 'package:hive/hive.dart';

part 'delivery_event_model_outdated.g.dart';

@HiveType(typeId: DeliveryEventModelOutdated.typeId)
class DeliveryEventModelOutdated extends HiveObject {
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

  DeliveryEventModelOutdated({
    required this.status,
    required this.data,
    required this.hora,
    this.origem,
    this.destino,
    this.local,
  });
}
