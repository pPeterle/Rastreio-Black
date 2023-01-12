import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/delivery_list_repository.dart';

abstract class DeleteDeliveryListUsecase {
  Future<Either<Failure, Unit>> call(DeliveryList deliveryList);
}

class DeleteDeliveryListUsecaseImpl implements DeleteDeliveryListUsecase {
  final DeliveryListRepository deliveryListRepository;

  DeleteDeliveryListUsecaseImpl(this.deliveryListRepository);

  @override
  Future<Either<Failure, Unit>> call(DeliveryList deliveryList) async {
    return deliveryListRepository.deleteDeliveryList(deliveryList);
  }
}
