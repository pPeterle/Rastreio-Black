import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_list.dart';
import 'package:hive/hive.dart';

part 'delivery_list_model.g.dart';

@HiveType(typeId: DeliveryListModel.typeId)
class DeliveryListModel extends HiveObject with EquatableMixin {
  static const typeId = 2;

  @HiveField(1)
  final String uuid;
  @HiveField(2)
  final String title;

  DeliveryListModel({
    required this.uuid,
    required this.title,
  });

  factory DeliveryListModel.fromDromain(
    DeliveryList deliveryList,
  ) {
    return DeliveryListModel(
      uuid: deliveryList.uuid,
      title: deliveryList.title,
    );
  }

  DeliveryListModel copyWith({
    String? uuid,
    String? title,
  }) =>
      DeliveryListModel(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
      );

  DeliveryList mapToDomain() => DeliveryList(
        uuid: uuid,
        title: title,
      );

  @override
  List<Object?> get props => [uuid, title];
}
