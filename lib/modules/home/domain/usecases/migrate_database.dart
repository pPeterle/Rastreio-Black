import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';

import '../repositories/delivery_repository.dart';

abstract class MigrateDatabaseUsecase {
  Future<Either<Failure, Unit>> call();
}

class MigrateDatabaseUsecaseImpl implements MigrateDatabaseUsecase {
  final DeliveryRepository _deliveryRepository;

  MigrateDatabaseUsecaseImpl(this._deliveryRepository);

  @override
  Future<Either<Failure, Unit>> call() async {
    return _deliveryRepository.migrateDatasource();
  }
}
