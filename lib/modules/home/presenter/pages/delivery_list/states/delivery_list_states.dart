import '../../../../domain/entities/delivery.dart';
import '../../../../domain/errors/errors.dart';

abstract class DeliveryListState {
  final String deliveryListId;

  DeliveryListState(this.deliveryListId);
}

class DeliveryListSuccess extends DeliveryListState {
  final List<Delivery> deliveries;
  final List<Delivery> completedDeliveries;

  DeliveryListSuccess({
    required this.deliveries,
    required this.completedDeliveries,
    required String deliveryListId,
  }) : super(deliveryListId);
}

class DeliveryListError extends DeliveryListState {
  final Failure error;

  DeliveryListError(super.deliveryListId, this.error);
}

class DeliveryListLoading extends DeliveryListState {
  DeliveryListLoading(super.deliveryListId);
}

class DeliveryListStart extends DeliveryListState {
  DeliveryListStart() : super("");
}
