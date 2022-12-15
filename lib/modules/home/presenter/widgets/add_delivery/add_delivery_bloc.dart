import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/add_delivery/states/add_delivery_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../events/home_events.dart';
import '../../home_bloc.dart';
import 'events/add_delivery_events.dart';

class AddDeliveryBloc extends Bloc<AddDeliveryEvents, AddDeliveryStates> {
  final SaveDeliveryUsecase rastrearEncomenda;
  final HomeBloc _homeBloc;

  AddDeliveryBloc(this.rastrearEncomenda, this._homeBloc)
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
    final result = await rastrearEncomenda(event.code, title: event.title);
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
        _homeBloc.add(GetHomeDataEvent());
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
