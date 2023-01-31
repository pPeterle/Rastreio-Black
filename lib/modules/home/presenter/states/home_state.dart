import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';

import '../../utils/order_by.dart';

abstract class HomeState {
  final List<DeliveryList> tabs;
  final int tabIndex;
  final OrderBy orderBy;

  HomeState({
    this.tabs = const [],
    this.tabIndex = 0,
    this.orderBy = OrderBy.date,
  });
}

class HomeSuccess extends HomeState {
  HomeSuccess({
    super.orderBy,
    super.tabs,
    super.tabIndex,
  });
}

class HomeError extends HomeState {
  final Failure error;

  HomeError(this.error);
}

class HomeLoading extends HomeState {}

class HomeStart extends HomeState {}
