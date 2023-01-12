import 'package:equatable/equatable.dart';

class DeliveryList with EquatableMixin {
  final String uuid;
  final String title;

  DeliveryList({
    required this.uuid,
    required this.title,
  });

  @override
  List<Object?> get props => [uuid, title];
}
