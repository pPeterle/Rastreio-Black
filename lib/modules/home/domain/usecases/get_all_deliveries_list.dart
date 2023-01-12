import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/delivery_list_repository.dart';

abstract class GetAllDeliveriesListUsecase {
  Future<Either<Failure, List<DeliveryList>>> call();
}

class GetAllDeliveriesListUsecaseImpl implements GetAllDeliveriesListUsecase {
  final DeliveryListRepository _deliveryRepository;

  GetAllDeliveriesListUsecaseImpl(this._deliveryRepository);

  @override
  Future<Either<Failure, List<DeliveryList>>> call() async {
    final result = await _deliveryRepository.getAllDeliveriesList();
    return result;
  }
}
