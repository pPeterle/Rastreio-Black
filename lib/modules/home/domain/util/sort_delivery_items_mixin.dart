import '../../utils/order_by.dart';
import '../entities/delivery.dart';

mixin SortDeliveryItemsMixin {
  List<Delivery> sortDeliveryList(List<Delivery> list, OrderBy orderBy) {
    switch (orderBy) {
      case OrderBy.date:
        list.sort((a, b) {
          final firstDate = a.events[0].data;
          final secondDate = b.events[0].data;

          return firstDate.isAfter(secondDate) ? -1 : 1;
        });
        break;

      case OrderBy.title:
        list.sort(
          (a, b) => a.title.compareTo(b.title),
        );
        break;
    }

    return list;
  }
}
