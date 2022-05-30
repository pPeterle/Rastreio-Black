import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';

abstract class LocalDeliveryDatasource {
  Future saveDeliveryModel(DeliveryModel deliveryModel);

  List<DeliveryModel> getAllDeliveryModels();
}
