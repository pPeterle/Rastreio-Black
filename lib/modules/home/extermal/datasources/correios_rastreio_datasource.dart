import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/remote_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_event_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';

class CorreiosRastreioDatasource implements RemoteDeliveryDataSource {
  final CorreiosRastreio correios;

  CorreiosRastreioDatasource(this.correios);

  @override
  Future<DeliveryModel> trackDelivery(
      String code, String deliveryListId) async {
    final delivery = await correios.rastrearEncomenda(code);
    final events = delivery.events
        .map(
          (e) => DeliveryEventModel(
            status: e.status,
            data: e.data,
            hora: e.hora,
            destino: e.destino,
            local: e.local,
            origem: e.origem,
          ),
        )
        .toList();
    return DeliveryModel(
        code: delivery.code,
        events: events,
        title: "",
        deliveryListId: deliveryListId);
  }
}
