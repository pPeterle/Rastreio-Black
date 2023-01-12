import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/edit_delivery/states/edit_delivery_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../add_delivery/states/add_delivery_states.dart';
import 'edit_delivery_bloc.dart';
import 'events/edit_delivery_events.dart';

class EditDeliveryBottomSheetWidget extends StatefulWidget {
  final Delivery delivery;
  const EditDeliveryBottomSheetWidget({Key? key, required this.delivery})
      : super(key: key);

  @override
  State<EditDeliveryBottomSheetWidget> createState() =>
      _EditDeliveryBottomSheetWidgetState();
}

class _EditDeliveryBottomSheetWidgetState
    extends State<EditDeliveryBottomSheetWidget> {
  final EditDeliveryBloc bloc = Modular.get();
  final HomeBloc homeBloc = Modular.get();

  final TextEditingController _codeTextEditingController =
      TextEditingController();
  final TextEditingController _titleTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _codeTextEditingController.text = widget.delivery.code;
    _titleTextEditingController.text = widget.delivery.title;

    bloc.stream.listen((event) {
      if (event is EditDeliveryForm) {
        final code = event.code;
        _codeTextEditingController.text =
            code ?? _codeTextEditingController.text;

        final title = event.title;
        _titleTextEditingController.text =
            title ?? _titleTextEditingController.text;
      }
    });
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<EditDeliveryStates>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              String? error;
              if (snapshot.data is AddDeliveryError) {
                error = (snapshot.data as AddDeliveryError).codeError;
              }
              return TextField(
                decoration:
                    InputDecoration(hintText: 'Código', errorText: error),
                controller: _codeTextEditingController,
                readOnly: true,
              );
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration.collapsed(hintText: 'Nome'),
            controller: _titleTextEditingController,
            autofocus: true,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              TextButton(onPressed: _saveDelivery, child: const Text('Salvar'))
            ],
          )
        ],
      ),
    );
  }

  void _saveDelivery() {
    bloc.add(
      SaveEditDelivery(
        code: _codeTextEditingController.text,
        title: _titleTextEditingController.text,
        deliveryListId: homeBloc.getDeliveryList.uuid,
      ),
    );
  }
}
