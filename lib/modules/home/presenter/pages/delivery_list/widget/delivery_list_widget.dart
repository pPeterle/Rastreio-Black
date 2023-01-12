import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/delivery_list_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/states/delivery_list_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../widgets/home_delivery_card.dart';
import 'home_empty_list_widget.dart';

class DeliveryListWidget extends StatefulWidget {
  final DeliveryListState state;
  final Future Function() onRefresh;

  const DeliveryListWidget(
      {super.key, required this.state, required this.onRefresh});

  @override
  State<DeliveryListWidget> createState() => _DeliveryListWidgetState();
}

class _DeliveryListWidgetState extends State<DeliveryListWidget>
    with SingleTickerProviderStateMixin {
  final DeliveryListBloc bloc = Modular.get();
  late final AnimationController animationController;

  bool isCompletedDeliveriesExpanded = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state is! DeliveryListSuccess) return Container();

    final deliveries = (widget.state as DeliveryListSuccess).deliveries;
    final completedDeliveries =
        (widget.state as DeliveryListSuccess).completedDeliveries;

    if (deliveries.isEmpty && completedDeliveries.isEmpty) {
      return const Center(
        child: HomeEmptyListWidget(),
      );
    }

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
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
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Column(
                    children: [
                      ListTile(
                        title:
                            Text("Finalizados (${completedDeliveries.length})"),
                        trailing: Transform.rotate(
                          angle: pi * animationController.value,
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                        onTap: () {
                          if (animationController.isCompleted) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                        },
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          IgnorePointer(
                            ignoring: animationController.value == 0,
                            child: Opacity(
                              opacity: animationController.value,
                              child: Column(
                                children: completedDeliveries
                                    .map((e) => HomeDeliveryCard(delivery: e))
                                    .toList(),
                              ),
                            ),
                          ),
                          IgnorePointer(
                            ignoring: animationController.value == 1,
                            child: Opacity(
                              opacity: 1 - animationController.value,
                              child: const HomeEmptyListWidget(),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
