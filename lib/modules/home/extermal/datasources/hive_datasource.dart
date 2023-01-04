import 'package:flutter_clean_architeture/modules/home/infra/datasource/local_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../infra/models/delivery_event_model.dart';

class HiveDatasource implements LocalDeliveryDatasource, Disposable {
  static const deliveryBoxKey = 'DeliveryBoxKey';
  late final Future<Box<DeliveryModel>> _box;

  HiveDatasource() {
    _box = _configure();
  }

  Future<Box<DeliveryModel>> _configure() async {
    await Hive.initFlutter();

    Hive.registerAdapter(DeliveryEventModelAdapter());
    Hive.registerAdapter(DeliveryModelAdapter());
    return Hive.openBox<DeliveryModel>(HiveDatasource.deliveryBoxKey);
  }

  @override
  Future<void> saveDeliveryModel(DeliveryModel deliveryModel) async {
    final box = await _box;
    box.put(deliveryModel.code, deliveryModel);
  }

  @override
  Future<List<DeliveryModel>> getAllDeliveryModels() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  void dispose() async {
    final box = await _box;
    box.close();
  }

  @override
  Future<void> deleteDeliveryModel(DeliveryModel deliveryModel) async {
    final box = await _box;
    return box.delete(deliveryModel.code);
  }
}
