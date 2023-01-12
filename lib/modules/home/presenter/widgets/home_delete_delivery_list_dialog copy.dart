import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_list.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/events/home_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeRenameDeliveryListDialog extends StatelessWidget {
  final DeliveryList deliveryList;
  final HomeBloc homeBloc = Modular.get();
  final TextEditingController textEditingController = TextEditingController();

  HomeRenameDeliveryListDialog({super.key, required this.deliveryList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Renomear lista ${deliveryList.title}'),
      content: TextField(
        controller: textEditingController,
        decoration: const InputDecoration(
          labelText: 'Nome',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Modular.to.pop();
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            homeBloc.add(
              RenameDeliveryListEvent(
                id: deliveryList.uuid,
                title: textEditingController.text,
              ),
            );
            Modular.to.popUntil(ModalRoute.withName('/'));
          },
          child: const Text(
            "Renomear",
          ),
        ),
      ],
    );
  }
}
