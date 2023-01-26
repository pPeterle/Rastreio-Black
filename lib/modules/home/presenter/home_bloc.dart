import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/delete_deleveries_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/rename_deliveries_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_delivery_list.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/delivery_list_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/events/delivery_list_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_clean_architeture/modules/home/utils/mixins/toast.dart';

import 'events/home_events.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> with ToastNotification {
  final GetAllDeliveriesListUsecase getAllDeliveriesListUsecase;
  final SaveDeliveryListUsecase saveDeliveryListUsecase;
  final RenameDeliveryListUsecase renameDeliveryListUsecase;
  final DeleteDeliveryListUsecase deleteDeliveryListUsecase;

  final DeliveryListBloc _deliveryListBloc;

  HomeBloc(
    this.getAllDeliveriesListUsecase,
    this.saveDeliveryListUsecase,
    this.renameDeliveryListUsecase,
    this.deleteDeliveryListUsecase,
    this._deliveryListBloc,
  ) : super(HomeStart()) {
    on<GetHomeDataEvent>(_getHomeData);
    on<ChangeOrderBy>(_changeOrderBy);
    on<AddNewDeliveryListEvent>(_newDeliveryList);
    on<RenameDeliveryListEvent>(_renameDeliveryList);
    on<DeleteDeliveryListEvent>(_deleteDeliveryList);
    on<UpdateTabIndex>(_updateTabIndex);
  }

  DeliveryList get getDeliveryList => state.tabs[state.tabIndex];

  Future<void> _changeOrderBy(
    ChangeOrderBy event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccess) return;
    final successState = state as HomeSuccess;

    emit(
      HomeSuccess(
        tabIndex: successState.tabIndex,
        tabs: successState.tabs,
        orderBy: event.orderBy,
      ),
    );

    _deliveryListBloc.add(
      GetDeliveryListDataEvent(
        id: getDeliveryList.uuid,
        orderBy: state.orderBy,
      ),
    );
  }

  Future<void> _newDeliveryList(
    AddNewDeliveryListEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await saveDeliveryListUsecase(event.title);
    result.fold(
      (l) {
        showText('Erro ao adicionar lista');
      },
      (r) {},
    );

    add(GetHomeDataEvent());
  }

  FutureOr<void> _getHomeData(
    GetHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await getAllDeliveriesListUsecase();

    final state = result.fold(
      (l) => HomeError(l),
      (r) => HomeSuccess(tabs: r, tabIndex: r.length - 1),
    );
    emit(state);
  }

  FutureOr<void> _renameDeliveryList(
    RenameDeliveryListEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await renameDeliveryListUsecase(event.id, event.title);
    result.fold(
      (l) {
        showText('Erro ao renomear lista');
      },
      (r) {},
    );

    add(GetHomeDataEvent());
  }

  FutureOr<void> _deleteDeliveryList(
    DeleteDeliveryListEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await deleteDeliveryListUsecase(event.deliveryList);
    result.fold(
      (l) {
        showText('Erro ao excluir lista');
      },
      (r) {},
    );

    add(GetHomeDataEvent());
  }

  FutureOr<void> _updateTabIndex(
    UpdateTabIndex event,
    Emitter<HomeState> emit,
  ) async {
    if (event.tabIndex == state.tabIndex) return;

    emit(
      HomeSuccess(
        tabs: state.tabs,
        tabIndex: event.tabIndex,
        orderBy: state.orderBy,
      ),
    );
  }
}
