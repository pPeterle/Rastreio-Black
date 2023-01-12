import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/util/sort_delivery_items_mixin.dart';
import 'package:flutter_clean_architeture/modules/home/utils/order_by.dart';

import '../repositories/delivery_repository.dart';

abstract class GetDeliveriesByListUsecase {
  Future<Either<Failure, List<Delivery>>> call({
    required String deliveryListId,
    OrderBy orderBy = OrderBy.date,
  });
}

class GetDeliveriesByListUsecaseImpl
    with SortDeliveryItemsMixin
    implements GetDeliveriesByListUsecase {
  final DeliveryRepository _deliveryRepository;

  GetDeliveriesByListUsecaseImpl(this._deliveryRepository);

  @override
  Future<Either<Failure, List<Delivery>>> call({
    required String deliveryListId,
    OrderBy orderBy = OrderBy.date,
  }) async {
    final result =
        await _deliveryRepository.getDeliveriesByList(deliveryListId);
    result.map((list) => sortDeliveryList(list, orderBy));

    return result;
  }
}
