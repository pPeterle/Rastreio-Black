import '../../../../domain/entities/delivery.dart';
import '../../../../domain/errors/errors.dart';

abstract class DeliveryListState {}

class DeliveryListSuccess implements DeliveryListState {
  final List<Delivery> deliveries;
  final List<Delivery> completedDeliveries;

  DeliveryListSuccess({
    required this.deliveries,
    required this.completedDeliveries,
  });
}

class DeliveryListError implements DeliveryListState {
  final Failure error;

  DeliveryListError(this.error);
}

class DeliveryListLoading implements DeliveryListState {}

class DeliveryListStart implements DeliveryListState {}
