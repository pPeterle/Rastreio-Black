import 'package:dartz/dartz.dart';

import '../entities/delivery.dart';
import '../errors/errors.dart';
import '../repositories/delivery_repository.dart';

abstract class UpdateDeliveriesUsecase {
  Future<Either<Failure, List<Delivery>>> call();
}

class UpdateDeliveriesUsecaseImpl implements UpdateDeliveriesUsecase {
  final DeliveryRepository _deliveryRepository;

  UpdateDeliveriesUsecaseImpl(this._deliveryRepository);

  @override
  Future<Either<Failure, List<Delivery>>> call() {
    return _deliveryRepository.updateDeliveries();
  }
}
