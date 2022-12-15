abstract class EditDeliveryEvents {}

class SaveEditDelivery extends EditDeliveryEvents {
  final String code;
  final String title;

  SaveEditDelivery({required this.code, required this.title});
}
