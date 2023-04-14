import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/events/home_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_add_tab_dialog.dart';

class HomeMenuListBottomSheet extends StatelessWidget {
  final HomeBloc bloc = Modular.get();

  HomeMenuListBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24, bottom: 12, right: 12),
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          final tabs = state.tabs;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...tabs.asMap().entries.map(
                    (entries) => ListTile(
                      title: Text(
                        entries.value.title,
                      ),
                      selected: entries.key == state.tabIndex,
                      onTap: () {
                        bloc.add(UpdateTabIndex(entries.key));
                        Modular.to.pop();
                      },
                    ),
                  ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Criar nova lista',
                ),
                leading: const Icon(Icons.add),
                iconColor: Colors.white.withOpacity(.8),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => HomeAddTabDialog(),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
