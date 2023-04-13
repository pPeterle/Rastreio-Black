import 'package:flutter_clean_architeture/modules/home/infra/datasource/local_delivery_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_list_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_unit_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../infra/models/delivery_event_model.dart';

class HiveDatasource implements LocalDeliveryDatasource, Disposable {
  static const deliveryBoxKey = 'DeliveryBoxKey';
  static const deliveryListBoxKey = 'deliveryListBoxKey';

  late final Future<Box<DeliveryModel>> _deliveryBox;
  late final Future<Box<DeliveryListModel>> _deliveryListBox;

  HiveDatasource() {
    _configure();
  }

  Future<void> _configure() async {
    _registerAdapters();

    _deliveryBox = Hive.openBox<DeliveryModel>(HiveDatasource.deliveryBoxKey);
    _deliveryListBox = Hive.openBox<DeliveryListModel>(
      HiveDatasource.deliveryListBoxKey,
    );
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(DeliveryModel.typeId)) {
      Hive.registerAdapter(DeliveryModelAdapter());
    }
    if (!Hive.isAdapterRegistered(DeliveryEventModel.typeId)) {
      Hive.registerAdapter(DeliveryEventModelAdapter());
    }
    if (!Hive.isAdapterRegistered(DeliveryListModel.typeId)) {
      Hive.registerAdapter(DeliveryListModelAdapter());
    }
    if (!Hive.isAdapterRegistered(DeliveryUnitModel.typeId)) {
      Hive.registerAdapter(DeliveryUnitModelAdapter());
    }
  }

  @override
  Future<void> saveDeliveryModel(DeliveryModel deliveryModel) async {
    final box = await _deliveryBox;
    box.put(deliveryModel.code, deliveryModel);
  }

  @override
  Future<List<DeliveryModel>> getAllDeliveryModels() async {
    final box = await _deliveryBox;
    return box.values.toList();
  }

  @override
  void dispose() async {
    final box = await _deliveryBox;
    box.close();
  }

  @override
  Future<void> deleteDeliveryModel(DeliveryModel deliveryModel) async {
    final box = await _deliveryBox;
    return box.delete(deliveryModel.code);
  }

  @override
  Future<List<DeliveryListModel>> getAllDeliveriesList() async {
    final box = await _deliveryListBox;
    return box.values.toList();
  }

  @override
  Future<void> saveDeliveryListModel(
    DeliveryListModel deliveryListModel,
  ) async {
    final box = await _deliveryListBox;
    box.put(deliveryListModel.uuid, deliveryListModel);
  }

  @override
  Future<void> deleteDeliveryListModel(
    DeliveryListModel deliveryListModel,
  ) async {
    final box = await _deliveryListBox;
    box.delete(deliveryListModel.uuid);
  }
}
