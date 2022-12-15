import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/edit_delivery/states/edit_delivery_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../events/home_events.dart';
import '../../home_bloc.dart';
import 'events/edit_delivery_events.dart';

class EditDeliveryBloc extends Bloc<EditDeliveryEvents, EditDeliveryStates> {
  final SaveDeliveryUsecase rastrearEncomenda;
  final HomeBloc _homeBloc;

  EditDeliveryBloc(this.rastrearEncomenda, this._homeBloc)
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
    final result = await rastrearEncomenda(event.code, title: event.title);
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
        _homeBloc.add(GetHomeDataEvent());
        Modular.to.pop(r);
      },
    );
  }
}
