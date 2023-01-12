import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';

abstract class RemoteDeliveryDataSource {
  Future<DeliveryModel> trackDelivery(String code, String deliveryListId);
}
