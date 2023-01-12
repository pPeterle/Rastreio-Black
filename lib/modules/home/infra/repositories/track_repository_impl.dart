import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/track_repository.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/remote_delivery_datasource.dart';

class TrackRepositoryImpl implements TrackRepository {
  final RemoteDeliveryDataSource _remoteDeliveryDataSource;

  TrackRepositoryImpl(this._remoteDeliveryDataSource);

  @override
  Future<Either<Failure, Delivery>> track({
    required String code,
    required String deliveryListId,
    String? title,
  }) async {
    try {
      final result = await _remoteDeliveryDataSource.trackDelivery(
        code,
        deliveryListId,
      );
      final delivery = result.copyWith(title: title);
      return Right(delivery.mapToDomain());
    } on CodeNotFound {
      return Left(CodeNotFoundError());
    } catch (e) {
      return Left(DataSourceError());
    }
  }
}
