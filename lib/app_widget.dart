import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'Rastreio No Ads',
      theme: ThemeData(
        useMaterial3: true,
        //colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff001d3d)),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff29B9F0),
          onPrimary: Colors.white,
          secondary: Color(0xff2F71E8),
          onSecondary: Colors.white,
          error: Color(0xffef233c),
          onError: Colors.white,
          background: Color(0xff111213),
          onBackground: Colors.white,
          surface: Color(0xff212224),
          onSurface: Color(0xffA1A1A1),
        ),
      ),
    );
  }
}
