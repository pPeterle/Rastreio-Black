import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/infra/datasource/remote_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_event_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_unit_model.dart';

class CorreiosRastreioDatasource implements RemoteDeliveryDataSource {
  final CorreiosRastreio correios;

  CorreiosRastreioDatasource(this.correios);

  @override
  Future<DeliveryModel> trackDelivery(
    String code,
    String deliveryListId,
  ) async {
    final delivery = await correios.rastrearEncomenda(code);
    final events = delivery.eventos
        .map(
          (e) => DeliveryEventModel(
            status: e.descricao,
            date: e.data,
            unity: DeliveryUnitModel(
              name: e.unidade.nome,
              city: e.unidade.endereco?.cidade ?? "",
              uf: e.unidade.endereco?.uf ?? "",
            ),
            destiny: e.unidadeDestino != null
                ? DeliveryUnitModel(
                    name: e.unidadeDestino!.nome,
                    city: e.unidadeDestino!.endereco?.cidade ?? "",
                    uf: e.unidadeDestino!.endereco?.uf ?? "",
                  )
                : null,
          ),
        )
        .toList();
    return DeliveryModel(
      code: delivery.codObjeto,
      expectedDate: delivery.dtPrevista != null
          ? DateTime.parse(delivery.dtPrevista!)
          : null,
      events: events,
      title: "",
      deliveryListId: deliveryListId,
    );
  }
}
