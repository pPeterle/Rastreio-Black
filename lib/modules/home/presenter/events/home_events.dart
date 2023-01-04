import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';

abstract class HomeEvents {}

class GetHomeDataEvent extends HomeEvents {}

class UpdateDeliveriesEvent extends HomeEvents {}

class DeleteDeliveryEvent extends HomeEvents {
  final Delivery delivery;

  DeleteDeliveryEvent(this.delivery);
}

class ChangeOrderBy extends HomeEvents {
  final OrderBy orderBy;

  ChangeOrderBy(this.orderBy);
}
