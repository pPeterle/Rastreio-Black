import 'package:dartz/dartz.dart';

import '../entities/delivery.dart';
import '../errors/errors.dart';

abstract class DeliveryRepository {
  Future<Either<Failure, List<Delivery>>> getDeliveriesByList(
    String deliveryListId,
  );
  Future<Either<Failure, List<Delivery>>> updateDeliveries();
  Future<Either<Failure, List<Delivery>>> getAllDeliveries();
  Future<Either<Failure, Delivery>> saveDelivery(Delivery delivery);
  Future<Either<Failure, Unit>> deleteDelivery(Delivery delivery);

  Future<Either<Failure, Unit>> migrateDatasource();
}
