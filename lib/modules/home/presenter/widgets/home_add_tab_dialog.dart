import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/events/home_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAddTabDialog extends StatelessWidget {
  final titleController = TextEditingController();
  final HomeBloc bloc = Modular.get();

  HomeAddTabDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Adicionar lista',
      ),
      content: TextField(
        controller: titleController,
        decoration: const InputDecoration(
          labelText: 'Nome',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            bloc.add(AddNewDeliveryListEvent(titleController.text));
            Modular.to.popUntil(ModalRoute.withName("/"));
          },
          child: const Text('Salvar'),
        )
      ],
    );
  }
}
