import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/local_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/remote_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/repositories/delivery_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DeliveryDatasourceMock extends Mock implements RemoteDeliveryDataSource {}

class HiveDataSourceMock extends Mock implements LocalDeliveryDatasource {}

class DeliveryModelFake extends Fake implements DeliveryModel {}

void main() {
  final remoteDatasource = DeliveryDatasourceMock();
  final localDatasource = HiveDataSourceMock();
  final repository = DeliveryRepositoryImpl(remoteDatasource, localDatasource);

  setUpAll(
    () {
      registerFallbackValue(DeliveryModelFake());
    },
  );

  test('deve retornar uma lista de delivery em caso de sucesso', () async {
    final delivery1 = DeliveryModel(
      code: 'ab',
      events: [],
      title: "a",
      deliveryListId: 'listId',
    );
    final delivery2 = DeliveryModel(
      code: 'abc',
      events: [],
      title: "b",
      deliveryListId: 'listId2',
    );

    when(() => localDatasource.getAllDeliveryModels())
        .thenAnswer((invocation) async => [delivery1, delivery2]);

    final result = await repository.getDeliveriesByList('listId');

    expect(
      result.getOrElse(() => fail('deve retornar um right')).first.title,
      "a",
    );
  });

  test(
      'deve retornar uma datasource ao buscar uma lista de delivery error em caso de erro',
      () async {
    when(() => localDatasource.getAllDeliveryModels())
        .thenThrow((invocation) async => Error());

    final result = await repository.getDeliveriesByList('listId');

    result.fold(
      (l) => expect(l, isA<DataSourceError>()),
      (r) => fail('Deve retornar um datasource error'),
    );
  });

  test('deve salvar um delivery em caso de sucesso', () async {
    final delivery = DeliveryModel(
      code: 'ab',
      events: [],
      title: "a",
      deliveryListId: 'listId',
    );

    when(() => localDatasource.saveDeliveryModel(any()))
        .thenAnswer((invocation) async => delivery);

    final result = await repository.saveDelivery(delivery.mapToDomain());

    expect(
      result.getOrElse(() => fail('deve retornar um right')).title,
      "a",
    );
  });

  test(
      'deve retornar uma datasource ao salvar um delivery error em caso de erro',
      () async {
    final delivery = DeliveryModel(
      code: 'ab',
      events: [],
      title: "a",
      deliveryListId: 'listId',
    );
    when(() => localDatasource.saveDeliveryModel(any()))
        .thenThrow((invocation) async => Error());

    final result = await repository.saveDelivery(delivery.mapToDomain());

    result.fold(
      (l) => expect(l, isA<DataSourceError>()),
      (r) => fail('Deve retornar um datasource error'),
    );
  });

  test('deve salvar um excluir em caso de sucesso', () async {
    final delivery = DeliveryModel(
      code: 'ab',
      events: [],
      title: "a",
      deliveryListId: 'listId',
    );

    when(() => localDatasource.deleteDeliveryModel(any()))
        .thenAnswer((invocation) async => {});

    final result = await repository.deleteDelivery(delivery.mapToDomain());

    expect(
      result.getOrElse(() => fail('deve retornar um right')),
      unit,
    );
  });

  test(
      'deve retornar uma datasource ao excluir um delivery error em caso de erro',
      () async {
    final delivery = DeliveryModel(
      code: 'ab',
      events: [],
      title: "a",
      deliveryListId: 'listId',
    );
    when(() => localDatasource.deleteDeliveryModel(any()))
        .thenThrow((invocation) async => Error());

    final result = await repository.deleteDelivery(delivery.mapToDomain());

    result.fold(
      (l) => expect(l, isA<DataSourceError>()),
      (r) => fail('Deve retornar um datasource error'),
    );
  });
}
