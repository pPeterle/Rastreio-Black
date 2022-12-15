import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/add_delivery/add_delivery_widget.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/edit_delivery/edit_delivery_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'events/home_events.dart';
import 'home_bloc.dart';
import 'states/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _animationBottomSheetController;
  late final Animation<double> _removeBottomAppBar;
  late final _scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeBloc bloc = Modular.get();

  @override
  void initState() {
    super.initState();
    initPlatformState();

    bloc.add(GetHomeDataEvent());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationBottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _removeBottomAppBar = Tween(begin: 0.0, end: 50.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          .5,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        showTrackDeliveryBottomSheet();
      }
    });

    _animationBottomSheetController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _removeBottomAppBar,
      builder: (context, widget) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Rastreio No Ads',
              style: TextStyle(
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: theme.colorScheme.background,
          ),
          backgroundColor: theme.colorScheme.background,
          body: StreamBuilder<HomeState>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.data is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data is HomeSuccess) {
                final list = (snapshot.data as HomeSuccess).list;
                return RefreshIndicator(
                  onRefresh: () async {
                    return bloc.add(UpdateDeliveriesEvent());
                  },
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final delivery = list[index];
                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: InkWell(
                          onTap: () {
                            Modular.to
                                .pushNamed('/delivery', arguments: delivery);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      delivery.title.isEmpty
                                          ? delivery.code
                                          : delivery.title,
                                      style: TextStyle(
                                        color: theme.colorScheme.secondary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${delivery.events[0].data} ${delivery.events[0].hora}",
                                      style: theme.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                Text(
                                  delivery.events[0].status,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                if (delivery.events[0].local != null)
                                  Text(
                                    delivery.events[0].local ?? "",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                Text(
                                  delivery.code,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          floatingActionButton: _getStartAnimationFab()
              ? FloatingActionButton(
                  onPressed: () {
                    _animationController.forward();
                  },
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Transform.translate(
            offset: Offset(0, _removeBottomAppBar.value),
            child: BottomAppBar(
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
                    onPressed: () {},
                    icon: const Icon(Icons.rotate_90_degrees_cw_sharp),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showTrackDeliveryBottomSheet() async {
    showModalBottomSheet(
      context: context,
      transitionAnimationController: _animationBottomSheetController,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddDeliveryBottomSheetWidget(),
      ),
    );
  }

  void editTrackDeliveryBottomSheet(Delivery delivery) {
    showModalBottomSheet(
      context: context,
      transitionAnimationController: _animationBottomSheetController,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditDeliveryBottomSheetWidget(delivery: delivery),
      ),
    );
  }

  bool _getStartAnimationFab() {
    bool showFab = true;
    switch (_animationController.status) {
      case AnimationStatus.forward:
        showFab = _animationController.value < .1;
        break;
      case AnimationStatus.reverse:
        showFab = _animationController.value < .9;
        break;
      case AnimationStatus.completed:
        showFab = false;
        break;
      case AnimationStatus.dismissed:
        showFab = true;
    }

    return showFab;
  }

  void initPlatformState() {
    BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          startOnBoot: true,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.NONE,
        ), (String taskId) async {
      BackgroundFetch.finish(taskId);
    }, (String taskId) {
      BackgroundFetch.finish(taskId);
    });
  }
}
