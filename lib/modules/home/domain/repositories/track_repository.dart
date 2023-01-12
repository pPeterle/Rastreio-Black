import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';

abstract class TrackRepository {
  Future<Either<Failure, Delivery>> track({
    required String code,
    required String deliveryListId,
    String? title,
  });
}
