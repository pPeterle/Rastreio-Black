import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_list_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/outdated/delivery_model_outdated.dart';

abstract class LocalDeliveryDatasource {
  Future<void> saveDeliveryModel(DeliveryModel deliveryModel);
  Future<void> saveDeliveryListModel(DeliveryListModel deliveryListModel);
  Future<void> deleteDeliveryListModel(DeliveryListModel deliveryListModel);

  Future<void> deleteDeliveryModel(DeliveryModel deliveryModel);

  Future<List<DeliveryModel>> getAllDeliveryModels();
  Future<List<DeliveryListModel>> getAllDeliveriesList();

  Future<List<DeliveryModelOutdated>> getAllDeliveryModelsOutdated();
  Future<void> deleteDeliveryModelOutdated(
    String code,
  );
}
