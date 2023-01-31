import 'package:flutter/material.dart';

class HomeBottomAppBar extends StatelessWidget {
  final void Function() onMenuPressed;
  final void Function() onOptionsPressed;

  const HomeBottomAppBar({
    Key? key,
    required this.onMenuPressed,
    required this.onOptionsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomAppBar(
      color: theme.colorScheme.surface,
      child: Row(
        children: [
          IconButton(
            onPressed: onMenuPressed,
            icon: const Icon(Icons.menu),
          ),
          IconButton(
            onPressed: onOptionsPressed,
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
