abstract class AddDeliveryEvents {}

class SaveDelivery extends AddDeliveryEvents {
  final String code;
  final String title;
  final String deliveryListId;

  SaveDelivery(
      {required this.code, required this.title, required this.deliveryListId});
}

class PasteCodeClipboard extends AddDeliveryEvents {
  final String? code;

  PasteCodeClipboard(this.code);
}
