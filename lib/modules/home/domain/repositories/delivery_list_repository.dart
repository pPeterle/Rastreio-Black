import 'package:dartz/dartz.dart';

import '../entities/delivery_list.dart';
import '../errors/errors.dart';

abstract class DeliveryListRepository {
  Future<Either<Failure, List<DeliveryList>>> getAllDeliveriesList();
  Future<Either<Failure, Unit>> saveDeliveryList(String title);
  Future<Either<Failure, Unit>> deleteDeliveryList(DeliveryList deliveryList);
  Future<Either<Failure, Unit>> renameDeliveryList(String id, String title);
}
