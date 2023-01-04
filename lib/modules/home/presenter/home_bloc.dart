import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/delete_delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/update_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';

import '../domain/entities/delivery.dart';
import 'events/home_events.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  final GetAllDeliveriesUsecase getAllDelivery;
  final UpdateDeliveriesUsecase updateDeliveriesUsecase;
  final DeleteDeliveryUsecase deleteDeliveriesUsecase;

  HomeBloc(
    this.getAllDelivery,
    this.updateDeliveriesUsecase,
    this.deleteDeliveriesUsecase,
  ) : super(HomeStart()) {
    on<GetHomeDataEvent>(_getAllDelivery);
    on<UpdateDeliveriesEvent>(_updateDeliveries);
    on<DeleteDeliveryEvent>(_deleteDelivery);
    on<ChangeOrderBy>(_changeOrderBy);
  }

  Future<void> _getAllDelivery(
    GetHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await getAllDelivery();
    final state = result.fold((l) => HomeError(l), _mapSuccess);
    emit(state);
  }

  Future<void> _updateDeliveries(
    UpdateDeliveriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await updateDeliveriesUsecase();
    final state = result.fold((l) => HomeError(l), _mapSuccess);
    emit(state);
  }

  Future<void> _deleteDelivery(
    DeleteDeliveryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await deleteDeliveriesUsecase(event.delivery);
    result.fold((l) => HomeError(l), (r) => add(GetHomeDataEvent()));
  }

  HomeSuccess _mapSuccess(List<Delivery> list) {
    final completedDeliveries =
        list.where((delivery) => delivery.isCompleted).toList();
    final onCompletedDeliveries =
        list.where((delivery) => !delivery.isCompleted).toList();

    return HomeSuccess(
      deliveries: onCompletedDeliveries,
      completedDeliveries: completedDeliveries,
    );
  }

  Future<void> _changeOrderBy(
    ChangeOrderBy event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccess) return;
    final successState = state as HomeSuccess;

    final deliveriesOrdered = orderList(successState.deliveries, event.orderBy);
    final completedDeliveriesOrdered =
        orderList(successState.completedDeliveries, event.orderBy);

    emit(
      HomeSuccess(
        deliveries: deliveriesOrdered,
        completedDeliveries: completedDeliveriesOrdered,
        orderBy: event.orderBy,
      ),
    );
  }

  List<Delivery> orderList(List<Delivery> list, OrderBy orderBy) {
    switch (orderBy) {
      case OrderBy.date:
        list.sort((a, b) {
          final firstDate = a.events[0].data.split('/');
          final secondDate = b.events[0].data.split('/');
          return DateTime(
            int.parse(firstDate[2]),
            int.parse(firstDate[1]),
            int.parse(firstDate[0]),
          ).isAfter(
            DateTime(
              int.parse(secondDate[2]),
              int.parse(secondDate[1]),
              int.parse(secondDate[0]),
            ),
          )
              ? 1
              : 0;
        });
        break;

      case OrderBy.title:
        list.sort(
          (a, b) => a.title.compareTo(b.title),
        );
        break;
    }

    return list;
  }
}
