abstract class EditDeliveryEvents {}

class SaveEditDelivery extends EditDeliveryEvents {
  final String code;
  final String title;
  final String deliveryListId;

  SaveEditDelivery(
      {required this.code, required this.title, required this.deliveryListId});
}
