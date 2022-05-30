import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';

abstract class HomeEvents {}

class GetHomeData extends HomeEvents {}

class NewDeliveryAdded extends HomeEvents {
  final Delivery delivery;

  NewDeliveryAdded(this.delivery);
}
