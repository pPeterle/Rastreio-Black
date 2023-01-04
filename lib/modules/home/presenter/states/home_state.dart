import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/errors/errors.dart';

abstract class HomeState {}

class HomeSuccess implements HomeState {
  final List<Delivery> deliveries;
  final List<Delivery> completedDeliveries;
  final OrderBy orderBy;

  HomeSuccess({
    required this.deliveries,
    required this.completedDeliveries,
    this.orderBy = OrderBy.date,
  });
}

class HomeError implements HomeState {
  final Failure error;

  HomeError(this.error);
}

class HomeLoading implements HomeState {}

class HomeStart implements HomeState {}

enum OrderBy { date, title }
