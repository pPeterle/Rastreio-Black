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
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          final tabs = state.tabs;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...tabs.asMap().entries.map(
                    (entries) => Container(
                      decoration: BoxDecoration(
                        color: entries.key == state.tabIndex
                            ? theme.colorScheme.primary.withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(24),
                        ),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.account_circle,
                          color: Colors.transparent,
                        ),
                        title: Text(
                          entries.value.title,
                        ),
                        textColor: theme.colorScheme.onBackground,
                        onTap: () {
                          bloc.add(UpdateTabIndex(entries.key));
                          Modular.to.pop();
                        },
                      ),
                    ),
                  ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.add,
                ),
                title: const Text(
                  'Criar nova lista',
                ),
                textColor: theme.colorScheme.onBackground,
                iconColor: theme.colorScheme.onBackground,
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
