import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery_list.dart';

import '../../utils/order_by.dart';

abstract class HomeEvents {}

class GetHomeDataEvent extends HomeEvents {}

class ChangeOrderBy extends HomeEvents {
  final OrderBy orderBy;

  ChangeOrderBy(this.orderBy);
}

class AddNewDeliveryListEvent extends HomeEvents {
  final String title;

  AddNewDeliveryListEvent(this.title);
}

class RenameDeliveryListEvent extends HomeEvents {
  final String title;
  final String id;

  RenameDeliveryListEvent({required this.id, required this.title});
}

class DeleteDeliveryListEvent extends HomeEvents {
  final DeliveryList deliveryList;

  DeleteDeliveryListEvent(this.deliveryList);
}

class UpdateTabIndex extends HomeEvents {
  final int tabIndex;

  UpdateTabIndex(this.tabIndex);
}
