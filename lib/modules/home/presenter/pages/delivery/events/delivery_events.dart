import '../../../../domain/entities/delivery.dart';

abstract class DeliveryEvents {}

class DeleteDeliveryEvent extends DeliveryEvents {
  final Delivery delivery;

  DeleteDeliveryEvent(this.delivery);
}
