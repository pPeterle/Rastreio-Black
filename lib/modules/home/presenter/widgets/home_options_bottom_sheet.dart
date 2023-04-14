import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/home_delete_delivery_list_dialog.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/home_rename_delivery_list_dialog.dart';
import 'package:flutter_clean_architeture/modules/home/utils/order_by.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_sort_list_dialog.dart';

class HomeOptionsBottomSheet extends StatelessWidget {
  HomeOptionsBottomSheet({
    Key? key,
  }) : super(key: key);

  final HomeBloc homeBloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: StreamBuilder<HomeState>(
        stream: homeBloc.stream,
        initialData: homeBloc.state,
        builder: (context, snapshot) {
          if (snapshot.data is! HomeSuccess) return Container();
          final state = snapshot.data as HomeSuccess;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  'Ordenar',
                ),
                subtitle: Text(
                  state.orderBy == OrderBy.title ? 'Título' : 'Data',
                ),
                textColor: theme.colorScheme.onBackground,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return HomeSortListDialog();
                    },
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Renomear',
                ),
                textColor: theme.colorScheme.onBackground,
                enabled: state.tabIndex != 0,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return HomeRenameDeliveryListDialog(
                        deliveryList: homeBloc.getDeliveryList,
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Apagar',
                ),
                textColor: theme.colorScheme.onBackground,
                enabled: state.tabIndex != 0,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return HomeDeleteDeliveryListDialog(
                        deliveryList: homeBloc.getDeliveryList,
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
