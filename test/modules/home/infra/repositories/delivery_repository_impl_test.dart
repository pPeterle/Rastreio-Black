import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/local_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/remote_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/repositories/delivery_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DeliveryDatasourceMock extends Mock implements RemoteDeliveryDataSource {}

class HiveDataSourceMock extends Mock implements LocalDeliveryDatasource {}

void main() {
  final remoteDatasource = DeliveryDatasourceMock();
  final localDatasource = HiveDataSourceMock();
  final repository = DeliveryRepositoryImpl(remoteDatasource, localDatasource);

  test('deve retornar um Delivery em caso de sucesso', () async {
    final delivery = DeliveryModel(code: 'ab', events: [], title: "");
    when(() => remoteDatasource.trackDelivery(any()))
        .thenAnswer((invocation) async => delivery);
    when(() => localDatasource.saveDeliveryModel(delivery))
        .thenAnswer((invocation) async => {});

    final result = await repository.track('abc');

    expect(
      result.getOrElse(() => fail('deve retornar um right')),
      isA<Delivery>(),
    );
  });

  test('deve retornar um CodeNotFoundError em caso de CodeNotFound', () async {
    when(() => remoteDatasource.trackDelivery(any())).thenThrow(CodeNotFound());

    final delivery = await repository.track('abc');

    expect(delivery.fold(id, id), isA<CodeNotFoundError>());
  });

  test(
      'deve retornar um DataSourceError em caso de erro generico quando buscar remoto',
      () async {
    when(() => remoteDatasource.trackDelivery(any())).thenThrow(Error());

    final delivery = await repository.track('abc');

    expect(delivery.fold(id, id), isA<DataSourceError>());
  });

  test('deve retornar o objeto salvo no banco local', () async {
    final delivery = DeliveryModel(code: 'ab', events: [], title: "");
    when(() => localDatasource.getAllDeliveryModels())
        .thenAnswer((i) async => [delivery]);

    final result = await repository.getAllDeliveries();

    expect(result.getOrElse(() => fail('Deve ser um right')).length, equals(1));
  });

  test(
      'deve retornar um DataSourceError em caso de erro generico quando buscar do banco',
      () async {
    final delivery = DeliveryModel(code: 'ab', events: [], title: "");
    when(() => localDatasource.getAllDeliveryModels()).thenThrow(Exception());

    final result = await repository.getAllDeliveries();

    expect(result.fold(id, id), isA<DataSourceError>());
  });
}
