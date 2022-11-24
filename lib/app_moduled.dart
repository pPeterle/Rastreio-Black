import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/correios_rastreio_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/hive_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/repositories/delivery_repository_impl.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/home_page.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/pages/delivery_page.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home/widgets/add_delivery/add_delivery_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/presenter/home/widgets/edit_delivery/edit_delivery_bloc.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => CorreiosRastreio()),
        Bind.singleton((i) => HiveDatasource()),
        Bind.singleton((i) => GetAllDeliveryUsecaseImpl(i.get())),
        Bind.singleton((i) => DeliveryRepositoryImpl(i.get(), i.get())),
        Bind.singleton((i) => SaveDeliveryUsecaseImpl(i.get())),
        Bind.singleton((i) => CorreiosRastreioDatasource(i.get())),
        Bind.singleton((i) => HomeBloc(i.get())),
        Bind.factory((i) => AddDeliveryBloc(i.get(), i.get())),
        Bind.factory((i) => EditDeliveryBloc(i.get(), i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: ((context, args) => const HomePage()),
        ),
        ChildRoute(
          '/delivery',
          child: ((context, args) => DeliveryPage(delivery: args.data)),
        ),
      ];
}
