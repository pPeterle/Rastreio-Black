import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/delivery_list_repository.dart';
import 'package:flutter_clean_architeture/modules/home/domain/util/delivery_code_validator.dart';

abstract class SaveDeliveryListUsecase {
  Future<Either<Failure, Unit>> call(String title);
}

class SaveDeliveryListUsecaseImpl
    with DeliveryCodeValitor
    implements SaveDeliveryListUsecase {
  final DeliveryListRepository deliveryListRepository;

  SaveDeliveryListUsecaseImpl(this.deliveryListRepository);

  @override
  Future<Either<Failure, Unit>> call(String title) async {
    return deliveryListRepository.saveDeliveryList(title);
  }
}
