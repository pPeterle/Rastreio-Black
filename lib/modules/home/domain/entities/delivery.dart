import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_event.dart';

class Delivery {
  final String code;
  final String title;
  final List<DeliveryEvent> events;

  Delivery({required this.code, required this.events, required this.title});

  static const _finalStatus = 'Objeto entregue ao destinatário';

  bool get isCompleted {
    return events[0].status == _finalStatus;
  }
}
