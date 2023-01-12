import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/track_repository.dart';
import 'package:flutter_clean_architeture/modules/home/domain/util/delivery_code_validator.dart';

import '../repositories/delivery_repository.dart';

abstract class SaveDeliveryUsecase {
  Future<Either<Failure, Delivery>> call({
    required String code,
    required String deliveryListId,
    String? title,
  });
}

class SaveDeliveryUsecaseImpl
    with DeliveryCodeValitor
    implements SaveDeliveryUsecase {
  final TrackRepository trackRepository;
  final DeliveryRepository deliveryRepository;

  SaveDeliveryUsecaseImpl(this.trackRepository, this.deliveryRepository);

  @override
  Future<Either<Failure, Delivery>> call({
    required String code,
    required String deliveryListId,
    String? title,
  }) async {
    if (!regexCodeValidator.hasMatch(code)) {
      return Left(InvalidTextError());
    }

    final track = await trackRepository.track(
      code: code,
      title: title,
      deliveryListId: deliveryListId,
    );
    return track.fold(
      (l) => left(l),
      (r) => deliveryRepository.saveDelivery(r),
    );
  }
}
