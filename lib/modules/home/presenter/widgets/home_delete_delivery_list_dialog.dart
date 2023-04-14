import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_list.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/events/home_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeDeleteDeliveryListDialog extends StatelessWidget {
  final DeliveryList deliveryList;
  final HomeBloc homeBloc = Modular.get();

  HomeDeleteDeliveryListDialog({super.key, required this.deliveryList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Apagar lista'),
      content:
          Text("Deseja apagar a lista de encomendas ${deliveryList.title}"),
      actions: [
        TextButton(
          onPressed: () {
            Modular.to.pop();
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            homeBloc.add(DeleteDeliveryListEvent(deliveryList));
            Modular.to.popUntil(ModalRoute.withName('/'));
          },
          child: const Text(
            "Apagar",
          ),
        ),
      ],
    );
  }
}
