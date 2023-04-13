import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_unit.dart';

class DeliveryEvent {
  final String status;
  final DateTime data;
  final DeliveryUnit unity;
  final DeliveryUnit? destiny;

  const DeliveryEvent({
    required this.status,
    required this.data,
    required this.unity,
    this.destiny,
  });
}
