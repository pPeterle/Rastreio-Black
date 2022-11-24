import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/app_moduled.dart';
import 'package:flutter_clean_architeture/app_widget.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/hive_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_event_model.dart';
import 'package:flutter_clean_architeture/modules/home/infra/models/delivery_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DeliveryEventsModelAdapter());
  Hive.registerAdapter(DeliveryModelAdapter());
  await Hive.openBox<DeliveryModel>(HiveDatasource.deliveryBoxKey);
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}
