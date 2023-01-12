import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/app_moduled.dart';
import 'package:flutter_clean_architeture/app_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}
