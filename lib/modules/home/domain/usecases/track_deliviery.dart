import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/repositories/track_repository.dart';

abstract class RastrearEncomenda {
  final regexCodeValidator = RegExp(r'(\w){2}(\d){8}(\w){2}');
  Future<Either<Failure, Delivery>> call(String code, {String? title});
}

class RastrearEncomendaImpl implements RastrearEncomenda {
  final DeliveryRepository repository;

  RastrearEncomendaImpl(this.repository);

  @override
  RegExp get regexCodeValidator => RegExp(r'([A-Z]){2}([0-9]){9}([A-Z]){2}');

  @override
  Future<Either<Failure, Delivery>> call(String code, {String? title}) async {
    if (!regexCodeValidator.hasMatch(code)) {
      return Left(InvalidTextError());
    }

    return repository.track(code, title: title);
  }
}
