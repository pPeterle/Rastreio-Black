import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/events/home_events.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery_list/delivery_list_page.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/states/home_state.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/add_delivery/add_delivery_widget.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/edit_delivery/edit_delivery_widget.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/home_app_bar.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/home_bottom_app_bar.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/home_options_bottom_sheet.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_bloc.dart';
import 'widgets/home_menu_list_bottom_sheet.dart';

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

  late TabController tabController;

  final HomeBloc bloc = Modular.get();

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 0, vsync: this);

    bloc.add(GetHomeDataEvent());

    setupTabBarListener();

    setupAnimations();

    setupAnimationListeners();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _removeBottomAppBar,
          child: TabBarView(
            controller: tabController,
            children: state.tabs
                .map(
                  (tab) => DeliveryListPage(
                    id: tab.uuid,
                  ),
                )
                .toList(),
          ),
          builder: (context, widget) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: HomeAppBar(
                tabController: tabController,
              ),
              backgroundColor: theme.colorScheme.background,
              body: widget,
              floatingActionButton: _getStartAnimationFab()
                  ? FloatingActionButton(
                      onPressed: () {
                        _animationController.forward();
                      },
                      elevation: 0,
                      child: const Icon(Icons.add),
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endContained,
              bottomNavigationBar: Transform.translate(
                offset: Offset(0, _removeBottomAppBar.value),
                child: HomeBottomAppBar(
                  onMenuPressed: showMenuBottomSheet,
                  onOptionsPressed: showOptionsBottomSheet,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void setupTabBarListener() {
    bloc.stream.listen((state) {
      if (tabController.length != state.tabs.length) {
        tabController.dispose();
        tabController = TabController(
          length: state.tabs.length,
          initialIndex: state.tabIndex,
          vsync: this,
        );

        tabController.addListener(() {
          bloc.add(UpdateTabIndex(tabController.index));
        });
      }

      tabController.animateTo(state.tabIndex);
    });
  }

  void setupAnimationListeners() {
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

  void setupAnimations() {
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
  }

  void showOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return HomeOptionsBottomSheet();
      },
    );
  }

  void showMenuBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return HomeMenuListBottomSheet();
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
}
