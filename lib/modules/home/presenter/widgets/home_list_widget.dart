import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../events/home_events.dart';
import 'home_delivery_card.dart';

class HomeListWidget extends StatelessWidget {
  final HomeBloc bloc = Modular.get();
  final HomeState homeState;

  HomeListWidget({super.key, required this.homeState});

  @override
  Widget build(BuildContext context) {
    if (homeState is! HomeSuccess) return Container();

    final deliveries = (homeState as HomeSuccess).deliveries;
    final completedDeliveries = (homeState as HomeSuccess).completedDeliveries;

    return RefreshIndicator(
      onRefresh: () async => bloc.add(UpdateDeliveriesEvent()),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: deliveries.length,
              (context, index) => HomeDeliveryCard(delivery: deliveries[index]),
            ),
          ),
          if (completedDeliveries.isNotEmpty)
            SliverToBoxAdapter(
              child: ExpansionTile(
                title: Text(
                  'Finalizados (${completedDeliveries.length})',
                ),
                children: completedDeliveries
                    .map((e) => HomeDeliveryCard(delivery: e))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
