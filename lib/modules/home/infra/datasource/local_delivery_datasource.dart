import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';

abstract class LocalDeliveryDatasource {
  Future<void> saveDeliveryModel(DeliveryModel deliveryModel);
  Future<void> deleteDeliveryModel(DeliveryModel deliveryModel);

  Future<List<DeliveryModel>> getAllDeliveryModels();
}
