import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_clean_architeture/modules/home/presenter/pages/delivery/delivery_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../widgets/edit_delivery/edit_delivery_widget.dart';
import 'events/delivery_events.dart';

class DeliveryPage extends StatefulWidget {
  final Delivery delivery;

  const DeliveryPage({Key? key, required this.delivery}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final DeliveryBloc deliveryBloc = Modular.get();
  final dateTimeFormat = DateFormat("dd/MM/yyyy HH:mm");
  final dateFormat = DateFormat("dd/MM/yyyy");

  late Delivery delivery;

  @override
  void initState() {
    super.initState();
    delivery = widget.delivery;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          delivery.title.isEmpty ? delivery.code : delivery.title,
          style: theme.textTheme.titleLarge,
        ),
        backgroundColor: theme.colorScheme.background,
        actions: [
          if (delivery.expectedDate != null)
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: theme.colorScheme.surface,
                    content: Text(
                      'Data prevista: ${dateFormat.format(delivery.expectedDate!)}',
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_month),
            ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Modular.to.pop();
                    openEditBottomSheet(context);
                  },
                  child: const Text('Editar'),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Modular.to.pop();
                    openDeleteModal(context);
                  },
                  child: const Text('Excluir'),
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: theme.colorScheme.background,
      body: ListView.builder(
        itemCount: delivery.events.length,
        itemBuilder: (context, index) {
          final event = delivery.events[index];
          return IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 3,
                        color: theme.colorScheme.tertiary,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == 0
                                ? theme.colorScheme.tertiary
                                : Colors.white,
                            border: Border.all(
                              color: theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateTimeFormat.format(event.data),
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.status,
                          style: index == 0
                              ? theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)
                              : theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              event.destiny == null
                                  ? Icons.location_on_outlined
                                  : Icons.local_shipping,
                              color: theme.colorScheme.tertiary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "${event.unity.name} - ${event.unity.city} / ${event.unity.uf}",
                                style: theme.textTheme.bodySmall,
                              ),
                            )
                          ],
                        ),
                        if (event.destiny != null)
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: theme.colorScheme.tertiary,
                              ),
                              Expanded(
                                child: Text(
                                  "${event.destiny!.name} - ${event.destiny!.city} / ${event.destiny!.uf}",
                                  style: theme.textTheme.bodySmall,
                                ),
                              )
                            ],
                          ),
                        const SizedBox(
                          height: 22,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void openEditBottomSheet(BuildContext context) async {
    final updatedDelivery = await showModalBottomSheet<Delivery>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditDeliveryBottomSheetWidget(delivery: delivery),
      ),
    );

    if (updatedDelivery == null) return;

    setState(() {
      delivery = updatedDelivery;
    });
  }

  void openDeleteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja excluir esta encomenda?'),
          actions: [
            TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                deliveryBloc.add(DeleteDeliveryEvent(delivery));
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
