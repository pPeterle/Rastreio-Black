import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/delete_delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/update_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';

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
  }

  Future<void> _getAllDelivery(
    GetHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await getAllDelivery();
    final state = result.fold((l) => HomeError(l), (r) => HomeSuccess(r));
    emit(state);
  }

  Future<void> _updateDeliveries(
    UpdateDeliveriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await updateDeliveriesUsecase();
    final state = result.fold((l) => HomeError(l), (r) => HomeSuccess(r));
    emit(state);
  }

  Future<void> _deleteDelivery(
    DeleteDeliveryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await deleteDeliveriesUsecase(event.delivery);
    final updateDelivery =
        await result.fold((l) async => left(l), (r) => getAllDelivery());
    final state =
        updateDelivery.fold((l) => HomeError(l), (r) => HomeSuccess(r));
    emit(state);
  }
}
