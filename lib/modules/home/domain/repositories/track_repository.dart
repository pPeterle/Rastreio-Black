import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';

abstract class DeliveryRepository {
  Future<Either<Failure, Delivery>> track(String code, {String? title});
  Future<Either<Failure, List<Delivery>>> getAllDeliveries();
  Future<Either<Failure, List<Delivery>>> updateDeliveries();
  Future<Either<Failure, Delivery>> saveDelivery(Delivery delivery);
  Future<Either<Failure, Unit>> deleteDelivery(Delivery delivery);
}
