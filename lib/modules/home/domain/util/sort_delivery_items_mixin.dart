import '../../utils/order_by.dart';
import '../entities/delivery.dart';

mixin SortDeliveryItemsMixin {
  List<Delivery> sortDeliveryList(List<Delivery> list, OrderBy orderBy) {
    switch (orderBy) {
      case OrderBy.date:
        list.sort((a, b) {
          final firstDate = a.events[0].data.split('/');
          final secondDate = b.events[0].data.split('/');
          return DateTime(
            int.parse(firstDate[2]),
            int.parse(firstDate[1]),
            int.parse(firstDate[0]),
          ).isAfter(
            DateTime(
              int.parse(secondDate[2]),
              int.parse(secondDate[1]),
              int.parse(secondDate[0]),
            ),
          )
              ? 1
              : 0;
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
