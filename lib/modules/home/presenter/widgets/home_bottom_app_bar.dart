import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/home_options_bottom_sheet.dart';

class HomeBottomAppBar extends StatelessWidget {
  const HomeBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomAppBar(
      color: theme.colorScheme.surface,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(),
        CircleBorder(),
      ),
      notchMargin: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(.2),
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(24),
                            ),
                          ),
                          child: const ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              color: Colors.transparent,
                            ),
                            title: Text(
                              'Minha lista',
                            ),
                          ),
                        ),
                        const Divider(),
                        const ListTile(
                          leading: Icon(
                            Icons.add,
                            color: Colors.white30,
                          ),
                          title: Text(
                            'Criar nova lista',
                            style: TextStyle(color: Colors.white30),
                          ),
                          subtitle: Text(
                            'Em breve',
                            style: TextStyle(color: Colors.white24),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.menu),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return HomeOptionsBottomSheet();
                },
              );
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
