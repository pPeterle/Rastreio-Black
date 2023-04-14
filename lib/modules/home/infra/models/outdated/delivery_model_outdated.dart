import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_event_model.dart';
import 'package:hive/hive.dart';

part 'delivery_model_outdated.g.dart';

@HiveType(typeId: DeliveryModelOutdated.typeId)
class DeliveryModelOutdated extends HiveObject {
  static const typeId = 0;

  @HiveField(4)
  final String deliveryListId;
  @HiveField(1)
  final String code;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final List<DeliveryEventModel> events;

  DeliveryModelOutdated({
    required this.code,
    required this.events,
    required this.title,
    required this.deliveryListId,
  });
}
