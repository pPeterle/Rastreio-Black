import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';

abstract class HomeEvents {}

class GetHomeDataEvent extends HomeEvents {}

class UpdateDeliveriesEvent extends HomeEvents {}

class DeleteDeliveryEvent extends HomeEvents {
  final Delivery delivery;

  DeleteDeliveryEvent(this.delivery);
}
