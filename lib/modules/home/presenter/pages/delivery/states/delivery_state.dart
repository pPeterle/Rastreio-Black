abstract class DeliveryState {}

class DeliveryStart extends DeliveryState {}

class DeliverySuccess extends DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliveryError extends DeliveryState {
  final String message;

  DeliveryError(this.message);
}
