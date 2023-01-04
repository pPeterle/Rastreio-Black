import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      centerTitle: true,
      title: Text(
        'Rastreio No Ads',
        style: TextStyle(
          color: theme.colorScheme.onBackground,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: theme.colorScheme.background,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
