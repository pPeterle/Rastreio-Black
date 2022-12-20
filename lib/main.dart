import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/app_moduled.dart';
import 'package:flutter_clean_architeture/app_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}
