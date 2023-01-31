import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/delivery_list_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/events/delivery_list_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/edit_delivery/states/edit_delivery_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'events/edit_delivery_events.dart';

class EditDeliveryBloc extends Bloc<EditDeliveryEvents, EditDeliveryStates> {
  final SaveDeliveryUsecase rastrearEncomenda;
  final DeliveryListBloc _deliveryListBloc;

  EditDeliveryBloc(this.rastrearEncomenda, this._deliveryListBloc)
      : super(
          EditDeliveryBaseState(
            canSaveDelivery: false,
          ),
        ) {
    on<SaveEditDelivery>(
      saveDelivery,
    );
  }

  void saveDelivery(
    SaveEditDelivery event,
    Emitter<EditDeliveryStates> emit,
  ) async {
    emit(EditDeliveryLoading());
    final result = await rastrearEncomenda(
      code: event.code,
      title: event.title,
      deliveryListId: event.deliveryListId,
    );
    return result.fold(
      (fail) {
        if (fail is DataSourceError) {
          emit(
            EditDeliveryError(
              genericError: 'Algum erro aconteceu ao buscar os dados',
            ),
          );
        } else if (fail is CodeNotFoundError || fail is InvalidTextError) {
          emit(EditDeliveryError(codeError: 'Código incorreto'));
        }
      },
      (r) {
        _deliveryListBloc
            .add(GetDeliveryListDataEvent(id: event.deliveryListId));
        Modular.to.pop(r);
      },
    );
  }
}
