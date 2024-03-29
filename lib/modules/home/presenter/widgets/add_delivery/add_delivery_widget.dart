import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/add_delivery/states/add_delivery_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'add_delivery_bloc.dart';
import 'events/add_delivery_events.dart';

class AddDeliveryBottomSheetWidget extends StatefulWidget {
  const AddDeliveryBottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<AddDeliveryBottomSheetWidget> createState() =>
      _AddDeliveryBottomSheetWidgetState();
}

class _AddDeliveryBottomSheetWidgetState
    extends State<AddDeliveryBottomSheetWidget> {
  final AddDeliveryBloc bloc = Modular.get();
  final HomeBloc homeBloc = Modular.get();
  final TextEditingController _codeTextEditingController =
      TextEditingController();
  final TextEditingController _titleTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    bloc.stream.listen((event) {
      if (event is AddDeliveryForm) {
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
          StreamBuilder<AddDeliveryStates>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              String? error;
              if (snapshot.data is AddDeliveryError) {
                error = (snapshot.data as AddDeliveryError).codeError;
              }
              return TextField(
                decoration: InputDecoration(
                  hintText: 'Código',
                  errorText: error,
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                controller: _codeTextEditingController,
              );
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration.collapsed(hintText: 'Nome'),
            controller: _titleTextEditingController,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.background,
                width: 1,
              ),
            ),
            child: const Text(
              "Atualmente, apenas o código dos correios é rastreado",
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Tooltip(
                message: 'Colar código',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.paste_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onTap: () async {
                      final clipbaord =
                          await Clipboard.getData(Clipboard.kTextPlain);
                      bloc.add(PasteCodeClipboard(clipbaord?.text));
                    },
                  ),
                ),
              ),
              const Spacer(),
              StreamBuilder<AddDeliveryStates>(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  if (snapshot.data is AddDeliveryLoading) {
                    return const CircularProgressIndicator();
                  }
                  return TextButton(
                    onPressed: _saveDelivery,
                    child: const Text('Salvar'),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  void _saveDelivery() {
    bloc.add(
      SaveDelivery(
        code: _codeTextEditingController.text,
        title: _titleTextEditingController.text,
        deliveryListId: homeBloc.getDeliveryList.uuid,
      ),
    );
  }
}
