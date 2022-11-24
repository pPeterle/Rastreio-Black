import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/events/home_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/widgets/add_delivery/events/add_delivery_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/widgets/add_delivery/states/add_delivery_states.dart';

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
    final result = await rastrearEncomenda(event.code, title: event.title);
    result.fold(
      (fail) {
        if (fail is DataSourceError) {
          emit(
            AddDeliveryError(
              genericError: 'Algum erro aconteceu ao buscar os dados',
            ),
          );
        } else if (fail is CodeNotFoundError || fail is InvalidTextError) {
          emit(AddDeliveryError(codeError: 'Código incorreto'));
        }
      },
      (r) => _homeBloc.add(GetHomeData()),
    );
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
