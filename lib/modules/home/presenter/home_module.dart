import 'package:flutter_clean_architeture/modules/home/domain/usecases/delete_deleveries_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_all_deliveries_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/get_deliveries_by_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/rename_deliveries_list.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_delivery_list.dart';
import 'package:flutter_clean_architeture/modules/home/infra/repositories/delivery_list_repository_impl.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/home_page.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery/delivery_page.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/add_delivery/add_delivery_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/widgets/edit_delivery/edit_delivery_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:correios_rastreio/correios_rastreio.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/delete_delivery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/save_deliviery.dart';
import 'package:flutter_clean_architeture/modules/home/domain/usecases/update_deliveries.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/correios_rastreio_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/extermal/datasources/hive_datasource.dart';
import 'package:flutter_clean_architeture/modules/home/infra/repositories/delivery_repository_impl.dart';
import 'package:flutter_clean_architeture/modules/home/infra/repositories/track_repository_impl.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery/delivery_bloc.dart';
import 'package:flutter_clean_architeture/modules/home/utils/jobs/fetch_job.dart';
import 'package:flutter_clean_architeture/modules/home/utils/services/notification_service.dart';

import 'pages/delivery_list/delivery_list_bloc.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => CorreiosRastreio()),
        Bind.singleton((i) => HiveDatasource()),
        Bind.singleton((i) => HiveDatasource()),
        Bind.singleton((i) => DeliveryListRepositoryImpl(i.get())),
        Bind.singleton((i) => DeleteDeliveryListUsecaseImpl(i.get())),
        Bind.singleton((i) => RenameDeliveryListUsecaseImpl(i.get())),
        Bind.singleton((i) => SaveDeliveryListUsecaseImpl(i.get())),
        Bind.singleton((i) => GetAllDeliveriesListUsecaseImpl(i.get())),
        Bind.singleton((i) => GetDeliveriesByListUsecaseImpl(i.get())),
        Bind.singleton((i) => GetAllDeliveriesUsecaseImpl(i.get())),
        Bind.singleton((i) => UpdateDeliveriesUsecaseImpl(i.get())),
        Bind.singleton((i) => TrackRepositoryImpl(i.get())),
        Bind.singleton((i) => DeleteDeliveryUsecaseImpl(i.get())),
        Bind.singleton((i) => DeliveryRepositoryImpl(i.get(), i.get())),
        Bind.singleton((i) => SaveDeliveryUsecaseImpl(i.get(), i.get())),
        Bind.singleton((i) => CorreiosRastreioDatasource(i.get())),
        Bind.singleton((i) => NotificationService()),
        Bind.singleton(
          (i) => HomeBloc(i.get(), i.get(), i.get(), i.get(), i.get()),
        ),
        Bind.singleton((i) => FetchJob(i.get(), i.get(), i.get())),
        Bind.singleton((i) => DeliveryBloc(i.get(), i.get())),
        Bind.factory((i) => AddDeliveryBloc(i.get(), i.get())),
        Bind.factory((i) => EditDeliveryBloc(i.get(), i.get())),
        Bind.factory((i) => DeliveryListBloc(
              i.get(),
              i.get(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const HomePage(),
        ),
        ChildRoute(
          '/delivery',
          child: ((context, args) => DeliveryPage(delivery: args.data)),
        ),
      ];
}
