import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery/events/delivery_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery/states/delivery_state.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/delivery_list_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/events/delivery_list_events.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/usecases/delete_delivery.dart';

class DeliveryBloc extends Bloc<DeliveryEvents, DeliveryState> {
  final DeleteDeliveryUsecase deleteDeliveriesUsecase;
  final DeliveryListBloc deliveryListBloc;

  DeliveryBloc(this.deleteDeliveriesUsecase, this.deliveryListBloc)
      : super(DeliveryStart()) {
    on<DeleteDeliveryEvent>(_deleteDelivery);
  }

  Future<void> _deleteDelivery(
    DeleteDeliveryEvent event,
    Emitter<DeliveryState> emit,
  ) async {
    emit(DeliveryLoading());
    final result = await deleteDeliveriesUsecase(event.delivery);
    result.fold((l) {
      emit(DeliveryError("Erro ao excluir encomenda"));
    }, (r) {
      emit(DeliverySuccess());
      Modular.to.popUntil(ModalRoute.withName('/home'));
      deliveryListBloc.add(
        GetDeliveryListDataEvent(
          id: event.delivery.deliveryListId,
        ),
      );
    });
  }
}
