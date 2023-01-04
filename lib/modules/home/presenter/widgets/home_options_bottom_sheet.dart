import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_sort_list_dialog.dart';

class HomeOptionsBottomSheet extends StatelessWidget {
  HomeOptionsBottomSheet({Key? key}) : super(key: key);

  final HomeBloc homeBloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: StreamBuilder<HomeState>(
        stream: homeBloc.stream,
        initialData: homeBloc.state,
        builder: (context, snapshot) {
          if (snapshot.data is! HomeSuccess) return Container();
          final state = snapshot.data as HomeSuccess;

          return ListTile(
            title: const Text('Ordenar'),
            subtitle: Text(state.orderBy.name),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return HomeSortListDialog();
                },
              );
            },
          );
        },
      ),
    );
  }
}
