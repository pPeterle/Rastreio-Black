import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/delivery_list_repository.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/local_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_list_model.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/delivery_list.dart';
import '../../domain/errors/errors.dart';

class DeliveryListRepositoryImpl implements DeliveryListRepository {
  final LocalDeliveryDatasource _localDeliveryDatasource;
  final defaultDeliveryListModel =
      DeliveryListModel(uuid: 'uuid', title: 'my title');

  DeliveryListRepositoryImpl(this._localDeliveryDatasource);

  @override
  Future<Either<Failure, List<DeliveryList>>> getAllDeliveriesList() async {
    try {
      List<DeliveryListModel> deliveriesList =
          await _localDeliveryDatasource.getAllDeliveriesList();

      if (!deliveriesList.contains(defaultDeliveryListModel)) {
        await _localDeliveryDatasource.saveDeliveryListModel(
          defaultDeliveryListModel,
        );
        deliveriesList = await _localDeliveryDatasource.getAllDeliveriesList();
      }

      deliveriesList.sort(
        (a, b) => a.uuid == defaultDeliveryListModel.uuid ? 0 : 1,
      );

      return Right(deliveriesList.map((d) => d.mapToDomain()).toList());
    } catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveDeliveryList(String title) async {
    try {
      await _localDeliveryDatasource.saveDeliveryListModel(
        DeliveryListModel(uuid: const Uuid().v1(), title: title),
      );
      return const Right(unit);
    } catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDeliveryList(
    DeliveryList deliveryList,
  ) async {
    try {
      final deliveries = await _localDeliveryDatasource.getAllDeliveryModels();

      await _localDeliveryDatasource.deleteDeliveryListModel(
        DeliveryListModel.fromDromain(deliveryList),
      );
      await Future.wait(
        deliveries
            .where((delivery) => delivery.deliveryListId == deliveryList.uuid)
            .map(
              (delivery) =>
                  _localDeliveryDatasource.deleteDeliveryModel(delivery),
            ),
      );
      return const Right(unit);
    } catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, Unit>> renameDeliveryList(
    String id,
    String title,
  ) async {
    try {
      await _localDeliveryDatasource.saveDeliveryListModel(
        DeliveryListModel(uuid: id, title: title),
      );
      return const Right(unit);
    } catch (e) {
      return Left(DataSourceError());
    }
  }
}
