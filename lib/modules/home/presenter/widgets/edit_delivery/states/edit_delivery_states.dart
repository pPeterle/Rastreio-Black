abstract class EditDeliveryStates {
  final bool canSaveDelivery;

  EditDeliveryStates({required this.canSaveDelivery});
}

class EditDeliveryBaseState extends EditDeliveryStates {
  EditDeliveryBaseState({required super.canSaveDelivery});
}

class EditDeliveryLoading extends EditDeliveryStates {
  EditDeliveryLoading() : super(canSaveDelivery: false);
}

class EditDeliveryForm extends EditDeliveryStates {
  final String? code;
  final String? title;
  EditDeliveryForm({
    this.code,
    this.title,
    required super.canSaveDelivery,
  });
}

class EditDeliveryError extends EditDeliveryStates {
  final String? codeError;
  final String? genericError;

  EditDeliveryError({this.genericError, this.codeError})
      : super(canSaveDelivery: true);
}

class EditDeliverySuccess extends EditDeliveryStates {
  EditDeliverySuccess() : super(canSaveDelivery: false);
}
