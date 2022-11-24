import 'package:flutter_clean_architeture/modules/home/infra/datasource/local_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatasource implements LocalDeliveryDatasource, Disposable {
  static const deliveryBoxKey = 'DeliveryBoxKey';

  late final Box<DeliveryModel> _box;

  HiveDatasource() {
    open();
  }

  open() async {
    _box = Hive.box<DeliveryModel>(deliveryBoxKey);
  }

  @override
  Future saveDeliveryModel(DeliveryModel deliveryModel) =>
      _box.put(deliveryModel.code, deliveryModel);

  @override
  List<DeliveryModel> getAllDeliveryModels() => _box.values.toList();

  @override
  void dispose() {
    _box.close();
  }

  @override
  Future<void> deleteDeliveryModel(DeliveryModel deliveryModel) {
    return _box.delete(deliveryModel.code);
  }
}
