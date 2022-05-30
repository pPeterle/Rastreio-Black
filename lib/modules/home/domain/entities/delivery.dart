import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_events.dart';

class Delivery {
  final String code;
  final String? title;
  final List<DeliveryEvents> events;

  Delivery({required this.code, required this.events, this.title});
}
