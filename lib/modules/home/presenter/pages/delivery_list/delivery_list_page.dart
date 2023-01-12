import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/delivery_list_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/states/delivery_list_states.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'events/delivery_list_events.dart';
import 'widget/delivery_list_loading_widget.dart';
import 'widget/delivery_list_widget.dart';

class DeliveryListPage extends StatefulWidget {
  final String id;
  const DeliveryListPage({super.key, required this.id});

  @override
  State<DeliveryListPage> createState() => _DeliveryListPageState();
}

class _DeliveryListPageState extends State<DeliveryListPage>
    with AutomaticKeepAliveClientMixin {
  final DeliveryListBloc bloc = Modular.get();
  final HomeBloc homeBloc = Modular.get();

  @override
  void initState() {
    bloc.add(
      GetDeliveryListDataEvent(
        id: widget.id,
        orderBy: homeBloc.state.orderBy,
      ),
    );
    print('init state');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<DeliveryListBloc, DeliveryListState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is DeliveryListError) {
          return const Center(
            child: Text('Algum erro aconteceu'),
          );
        }

        return AnimatedCrossFade(
          secondChild: state is DeliveryListLoading
              ? const DeliveryListLoadingWidget()
              : Container(),
          firstChild: DeliveryListWidget(
            state: state,
            onRefresh: () async {
              bloc.add(UpdateDeliveriesEvent(widget.id));
            },
          ),
          crossFadeState: state is DeliveryListSuccess
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
