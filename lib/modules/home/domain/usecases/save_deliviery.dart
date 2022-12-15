import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/track_repository.dart';
import 'package:flutter_clean_architeture/modules/home/domain/util/delivery_code_validator.dart';

abstract class SaveDeliveryUsecase {
  Future<Either<Failure, Delivery>> call(String code, {String? title});
}

class SaveDeliveryUsecaseImpl
    with DeliveryCodeValitor
    implements SaveDeliveryUsecase {
  final DeliveryRepository repository;

  SaveDeliveryUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, Delivery>> call(String code, {String? title}) async {
    if (!regexCodeValidator.hasMatch(code)) {
      return Left(InvalidTextError());
    }

    final track = await repository.track(code, title: title);
    return track.fold((l) => left(l), (r) => repository.saveDelivery(r));
  }
}
