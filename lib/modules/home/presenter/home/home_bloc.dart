import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_delivery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/events/home_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/states/home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  final GetAllDeliveryUsecase getAllDelivery;

  HomeBloc(this.getAllDelivery) : super(HomeStart()) {
    on<GetHomeData>(_getAllDelivery);
  }

  FutureOr<void> _getAllDelivery(
    GetHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await getAllDelivery();
    result.fold((l) => HomeError(l), (r) => emit(HomeSuccess(r)));
  }
}
