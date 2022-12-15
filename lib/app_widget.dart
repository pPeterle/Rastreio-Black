import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/utils/jobs/fetch_job.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
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

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  print('headless task');
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    BackgroundFetch.finish(taskId);
    return;
  }

  FetchJob job = Modular.get();

  await job.fetchData();

  // Do your work here...
  BackgroundFetch.finish(taskId);
}
