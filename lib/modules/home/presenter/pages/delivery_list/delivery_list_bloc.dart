import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_deliveries_by_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/update_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/events/delivery_list_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/states/delivery_list_states.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/delivery.dart';

class DeliveryListBloc extends Bloc<DeliveryListEvents, DeliveryListState>
    implements Disposable {
  final GetDeliveriesByListUsecase getDeliveriesByList;
  final UpdateDeliveriesUsecase updateDeliveriesUsecase;

  late final StreamSubscription<HomeState> _streamSubscription;

  DeliveryListBloc(
    this.getDeliveriesByList,
    this.updateDeliveriesUsecase,
  ) : super(DeliveryListStart()) {
    on<GetDeliveryListDataEvent>(_getAllDelivery);
    on<UpdateDeliveriesEvent>(_updateDeliveries);
  }

  Future<void> _getAllDelivery(
    GetDeliveryListDataEvent event,
    Emitter<DeliveryListState> emit,
  ) async {
    final result = await getDeliveriesByList(
      deliveryListId: event.id,
      orderBy: event.orderBy,
    );
    final state = result.fold(
      (l) => DeliveryListError(event.id, l),
      (r) => _mapSuccess(r, event.id),
    );
    emit(state);
  }

  Future<void> _updateDeliveries(
    UpdateDeliveriesEvent event,
    Emitter<DeliveryListState> emit,
  ) async {
    emit(DeliveryListLoading(event.id));
    final result = await updateDeliveriesUsecase();
    final state = result.fold(
      (l) => DeliveryListError(event.id, l),
      (r) => _mapSuccess(r, event.id),
    );
    emit(state);
  }

  DeliveryListSuccess _mapSuccess(List<Delivery> list, String deliveryListId) {
    final completedDeliveries =
        list.where((delivery) => delivery.isCompleted).toList();
    final onCompletedDeliveries =
        list.where((delivery) => !delivery.isCompleted).toList();

    return DeliveryListSuccess(
      deliveryListId: deliveryListId,
      deliveries: onCompletedDeliveries,
      completedDeliveries: completedDeliveries,
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
  }
}
