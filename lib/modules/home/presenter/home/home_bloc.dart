import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_delivery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/events/home_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/states/home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  final GetAllDelivery getAllDelivery;

  HomeBloc(this.getAllDelivery) : super(HomeStart()) {
    on<GetHomeData>(_getAllDelivery);
    on<NewDeliveryAdded>(_newDeliveryAdded);
  }

  FutureOr<void> _getAllDelivery(
    GetHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await getAllDelivery();
    result.fold((l) => HomeError(l), (r) => emit(HomeSuccess(r)));
  }

  FutureOr<void> _newDeliveryAdded(
    NewDeliveryAdded event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeSuccess) {
      final list = (state as HomeSuccess).list;
      list.add(event.delivery);
      emit(HomeSuccess(list));
    }
  }
}
