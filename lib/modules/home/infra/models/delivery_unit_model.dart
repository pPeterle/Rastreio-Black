import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_unit.dart';
import 'package:hive/hive.dart';

part 'delivery_unit_model.g.dart';

@HiveType(typeId: DeliveryUnitModel.typeId)
class DeliveryUnitModel extends HiveObject {
  static const typeId = 3;

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String city;
  @HiveField(2)
  final String uf;

  DeliveryUnitModel({
    required this.name,
    required this.city,
    required this.uf,
  });

  factory DeliveryUnitModel.fromDomain(DeliveryUnit unit) {
    return DeliveryUnitModel(
      city: unit.city,
      name: unit.name,
      uf: unit.uf,
    );
  }

  DeliveryUnit mapToDomain() => DeliveryUnit(
        city: city,
        name: name,
        uf: uf,
      );
}
