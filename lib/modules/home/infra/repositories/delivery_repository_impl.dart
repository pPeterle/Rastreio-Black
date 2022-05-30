import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/track_repository.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/local_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/remote_delivery_datasource.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  final RemoteDeliveryDataSource _remoteDatasource;
  final LocalDeliveryDatasource _localDatasource;

  DeliveryRepositoryImpl(this._remoteDatasource, this._localDatasource);

  @override
  Future<Either<Failure, Delivery>> track(String code, {String? title}) async {
    try {
      final result = await _remoteDatasource.trackDelivery(code);
      final delivery = result.copyWith(title: title);
      await _localDatasource.saveDeliveryModel(delivery);
      return Right(delivery.mapToDomain());
    } on CodeNotFound {
      return Left(CodeNotFoundError());
    } catch (e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<Failure, List<Delivery>>> getAllDeliveries() {
    try {
      final result = _localDatasource.getAllDeliveryModels();
      return Future.value(
        Right(
          result.map((delivery) => delivery.mapToDomain()).toList(),
        ),
      );
    } catch (e) {
      return Future.value(Left(DataSourceError()));
    }
  }
}
