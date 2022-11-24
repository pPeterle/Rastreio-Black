import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/track_repository.dart';

abstract class DeleteDeliveryUsecase {
  Future<Either<Failure, Unit>> call(Delivery delivery);
}

class DeleteDeliveryUsecaseImpl implements DeleteDeliveryUsecase {
  final DeliveryRepository repository;

  DeleteDeliveryUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Delivery delivery) async {
    return repository.deleteDelivery(delivery);
  }
}
