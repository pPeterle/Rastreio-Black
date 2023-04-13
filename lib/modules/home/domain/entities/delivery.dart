import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_event.dart';

class Delivery {
  final String deliveryListId;
  final String code;
  final DateTime expectedDate;
  final String title;
  final List<DeliveryEvent> events;

  Delivery({
    required this.code,
    required this.events,
    required this.expectedDate,
    required this.title,
    required this.deliveryListId,
  });

  static const _finalStatus = 'Objeto entregue ao destinatário';

  bool get isCompleted {
    return events[0].status == _finalStatus;
  }

  int get id {
    final regex = RegExp(r'[^0-9]');
    return int.parse(code.replaceAll(regex, ''));
  }
}
