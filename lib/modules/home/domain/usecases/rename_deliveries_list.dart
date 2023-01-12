import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/delivery_list_repository.dart';

abstract class RenameDeliveryListUsecase {
  Future<Either<Failure, Unit>> call(String id, String title);
}

class RenameDeliveryListUsecaseImpl implements RenameDeliveryListUsecase {
  final DeliveryListRepository deliveryListRepository;

  RenameDeliveryListUsecaseImpl(this.deliveryListRepository);

  @override
  Future<Either<Failure, Unit>> call(String id, String title) async {
    return deliveryListRepository.renameDeliveryList(id, title);
  }
}
