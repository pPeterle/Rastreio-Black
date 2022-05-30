abstract class AddDeliveryEvents {}

class SaveDelivery extends AddDeliveryEvents {
  final String code;
  final String title;

  SaveDelivery({required this.code, required this.title});
}

class PasteCodeClipboard extends AddDeliveryEvents {
  final String? code;

  PasteCodeClipboard(this.code);
}
