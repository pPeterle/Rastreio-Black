import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_event.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_unit_model.dart';
import 'package:hive/hive.dart';

part 'delivery_event_model.g.dart';

@HiveType(typeId: DeliveryEventModel.typeId)
class DeliveryEventModel extends HiveObject {
  static const typeId = 5;

  @HiveField(0)
  final String status;
  @HiveField(1)
  final DateTime date;
  @HiveField(4)
  final DeliveryUnitModel? destiny;
  @HiveField(5)
  final DeliveryUnitModel unity;

  DeliveryEventModel({
    required this.status,
    required this.date,
    required this.unity,
    this.destiny,
  });

  factory DeliveryEventModel.fromDomain(DeliveryEvent event) {
    return DeliveryEventModel(
      status: event.status,
      date: event.data,
      destiny: event.destiny != null
          ? DeliveryUnitModel.fromDomain(event.destiny!)
          : null,
      unity: DeliveryUnitModel.fromDomain(event.unity),
    );
  }

  DeliveryEvent mapToDomain() => DeliveryEvent(
        data: date,
        status: status,
        unity: unity.mapToDomain(),
        destiny: destiny?.mapToDomain(),
      );
}
