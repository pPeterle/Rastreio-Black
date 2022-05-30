import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/correios_rastreio_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CorreiosRastreioMock extends Mock implements CorreiosRastreio {}

void main() {
  final correiosMock = CorreiosRastreioMock();
  final datasource = CorreiosRastreioDatasource(correiosMock);

  test('deve retornar um delivery Model', () async {
    when(() => correiosMock.rastrearEncomenda(any()))
        .thenAnswer((a) async => RastreioModel(code: '', events: []));

    final delivery = await datasource.trackDelivery('abc');
    expect(delivery, isA<DeliveryModel>());
  });
}
