import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final HomeBloc bloc = Modular.get();
  final TabController tabController;
  HomeAppBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: Text(
            'Rastreio Black',
            style: TextStyle(
              color: theme.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: theme.colorScheme.background,
          shape: Border(
            bottom: BorderSide(color: theme.colorScheme.surface),
          ),
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: 16),
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.onSurface,
            indicator: UnderlineTabIndicator(
              borderSide:
                  BorderSide(color: theme.colorScheme.primary, width: 2),
              insets: const EdgeInsets.symmetric(horizontal: 24),
            ),
            tabs: state.tabs
                .map(
                  (tab) => Tab(
                    text: tab.title,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
