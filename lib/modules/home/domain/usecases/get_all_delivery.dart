import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/track_repository.dart';

abstract class GetAllDelivery {
  Future<Either<Failure, List<Delivery>>> call();
}

class GetAllDeliveryImpl implements GetAllDelivery {
  final DeliveryRepository _deliveryRepository;

  GetAllDeliveryImpl(this._deliveryRepository);

  @override
  Future<Either<Failure, List<Delivery>>> call() {
    return _deliveryRepository.getAllDeliveries();
  }
}
