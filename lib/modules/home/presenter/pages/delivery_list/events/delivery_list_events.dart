import 'package:flutter_clean_architeture/modules/home/utils/order_by.dart';

abstract class DeliveryListEvents {}

class GetDeliveryListDataEvent extends DeliveryListEvents {
  final String id;
  final OrderBy orderBy;

  GetDeliveryListDataEvent({required this.id, this.orderBy = OrderBy.date});
}

class UpdateDeliveriesEvent extends DeliveryListEvents {
  final String id;

  UpdateDeliveriesEvent(this.id);
}
