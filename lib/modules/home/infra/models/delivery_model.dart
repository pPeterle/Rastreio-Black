import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_event_model.dart';
import 'package:hive/hive.dart';

part 'delivery_model.g.dart';

@HiveType(typeId: DeliveryModel.typeId)
class DeliveryModel extends HiveObject {
  static const typeId = 0;

  @HiveField(5)
  final DateTime expectedDate;
  @HiveField(4)
  final String deliveryListId;
  @HiveField(1)
  final String code;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final List<DeliveryEventModel> events;

  DeliveryModel({
    required this.code,
    required this.events,
    required this.expectedDate,
    required this.title,
    required this.deliveryListId,
  });

  factory DeliveryModel.fromDromain(
    Delivery delivery,
  ) {
    return DeliveryModel(
      code: delivery.code,
      expectedDate: delivery.expectedDate,
      events:
          delivery.events.map((e) => DeliveryEventModel.fromDomain(e)).toList(),
      title: delivery.title,
      deliveryListId: delivery.deliveryListId,
    );
  }

  DeliveryModel copyWith({
    String? code,
    List<DeliveryEventModel>? events,
    String? title,
    DateTime? expectedDate,
  }) =>
      DeliveryModel(
        code: code ?? this.code,
        events: events ?? this.events,
        title: title ?? this.title,
        deliveryListId: deliveryListId,
        expectedDate: expectedDate ?? this.expectedDate,
      );

  Delivery mapToDomain() => Delivery(
        code: code,
        events: events.map((e) => e.mapToDomain()).toList(),
        title: title,
        deliveryListId: deliveryListId,
        expectedDate: expectedDate,
      );
}
