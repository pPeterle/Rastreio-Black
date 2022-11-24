mixin DeliveryCodeValitor {
  final regexCodeValidator = RegExp(r'(\w){2}(\d){8}(\w){2}');
}
