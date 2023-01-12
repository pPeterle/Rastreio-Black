import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/home_menu_list_bottom_sheet.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/home_options_bottom_sheet.dart';

class HomeBottomAppBar extends StatelessWidget {
  const HomeBottomAppBar({
    Key? key,
  }) : super(key: key);

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
                builder: (_) {
                  return HomeMenuListBottomSheet();
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
