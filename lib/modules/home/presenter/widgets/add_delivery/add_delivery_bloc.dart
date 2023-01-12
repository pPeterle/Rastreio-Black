import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/delivery_list_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/events/delivery_list_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/add_delivery/states/add_delivery_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'events/add_delivery_events.dart';

class AddDeliveryBloc extends Bloc<AddDeliveryEvents, AddDeliveryStates> {
  final SaveDeliveryUsecase rastrearEncomenda;
  final DeliveryListBloc _deliveryListBloc;

  AddDeliveryBloc(this.rastrearEncomenda, this._deliveryListBloc)
      : super(
          AddDeliveryBaseState(
            canSaveDelivery: false,
          ),
        ) {
    on<SaveDelivery>(
      saveDelivery,
    );
    on<PasteCodeClipboard>(
      _pasteCodeClipboard,
    );
  }

  saveDelivery(SaveDelivery event, Emitter<AddDeliveryStates> emit) async {
    emit(AddDeliveryLoading());
    final result = await rastrearEncomenda(
      code: event.code,
      title: event.title,
      deliveryListId: event.deliveryListId,
    );
    final newState = result.fold(
      (fail) {
        if (fail is CodeNotFoundError || fail is InvalidTextError) {
          return AddDeliveryError(codeError: 'Código incorreto');
        }

        return AddDeliveryError(
          genericError: 'Algum erro aconteceu ao buscar os dados',
        );
      },
      (r) {
        _deliveryListBloc
            .add(GetDeliveryListDataEvent(id: event.deliveryListId));
        Modular.to.pop();
        return AddDeliveryBaseState(canSaveDelivery: true);
      },
    );
    emit(newState);
  }

  FutureOr<void> _pasteCodeClipboard(
    PasteCodeClipboard event,
    Emitter<AddDeliveryStates> emit,
  ) {
    emit(
      AddDeliveryForm(canSaveDelivery: true, code: event.code),
    );
  }
}
