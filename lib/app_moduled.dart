import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/delete_delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/update_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/correios_rastreio_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/hive_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/repositories/delivery_repository_impl.dart';
import 'package:flutter_clean_architeture/modules/home/utils/jobs/fetch_job.dart';
import 'package:flutter_clean_architeture/modules/home/utils/services/notification_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/presenter/home_bloc.dart';
import 'modules/home/presenter/home_page.dart';
import 'modules/home/presenter/pages/delivery_page.dart';
import 'modules/home/presenter/widgets/add_delivery/add_delivery_bloc.dart';
import 'modules/home/presenter/widgets/edit_delivery/edit_delivery_bloc.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => CorreiosRastreio()),
        Bind.singleton((i) => HiveDatasource()),
        Bind.singleton((i) => GetAllDeliveriesUsecaseImpl(i.get())),
        Bind.singleton((i) => UpdateDeliveriesUsecaseImpl(i.get())),
        Bind.singleton((i) => DeleteDeliveryUsecaseImpl(i.get())),
        Bind.singleton((i) => DeliveryRepositoryImpl(i.get(), i.get())),
        Bind.singleton((i) => SaveDeliveryUsecaseImpl(i.get())),
        Bind.singleton((i) => CorreiosRastreioDatasource(i.get())),
        Bind.singleton((i) => NotificationService()),
        Bind.singleton((i) => HomeBloc(i.get(), i.get(), i.get())),
        Bind.singleton((i) => FetchJob(i.get(), i.get(), i.get())),
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
