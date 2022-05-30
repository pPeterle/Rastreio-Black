abstract class AddDeliveryStates {
  final bool canSaveDelivery;

  AddDeliveryStates({required this.canSaveDelivery});
}

class AddDeliveryBaseState extends AddDeliveryStates {
  AddDeliveryBaseState({required super.canSaveDelivery});
}

class AddDeliveryLoading extends AddDeliveryStates {
  AddDeliveryLoading() : super(canSaveDelivery: false);
}

class AddDeliveryForm extends AddDeliveryStates {
  final String? code;
  final String? title;
  AddDeliveryForm({
    this.code,
    this.title,
    required super.canSaveDelivery,
  });
}

class AddDeliveryError extends AddDeliveryStates {
  final String? codeError;
  final String? genericError;

  AddDeliveryError({this.genericError, this.codeError})
      : super(canSaveDelivery: true);
}

class AddDeliverySuccess extends AddDeliveryStates {
  AddDeliverySuccess() : super(canSaveDelivery: false);
}
