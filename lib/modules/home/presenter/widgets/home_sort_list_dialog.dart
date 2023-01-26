import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/order_by.dart';
import '../events/home_events.dart';

class HomeSortListDialog extends StatelessWidget {
  HomeSortListDialog({Key? key}) : super(key: key);

  final HomeBloc homeBloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<HomeState>(
          stream: homeBloc.stream,
          initialData: homeBloc.state,
          builder: (context, snapshot) {
            if (snapshot.data is! HomeSuccess) return Container();
            final state = snapshot.data as HomeSuccess;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Text(
                    'Ordenar por:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RadioListTile<OrderBy>(
                  value: OrderBy.date,
                  groupValue: state.orderBy,
                  onChanged: (value) {
                    homeBloc.add(ChangeOrderBy(value!));
                    Modular.to.pop();
                  },
                  title: const Text('Data'),
                ),
                RadioListTile<OrderBy>(
                  value: OrderBy.title,
                  groupValue: state.orderBy,
                  onChanged: (value) {
                    homeBloc.add(ChangeOrderBy(value!));
                    Modular.to.pop();
                  },
                  title: const Text('Título'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
