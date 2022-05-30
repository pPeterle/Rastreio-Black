import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';

class DeliveryPage extends StatelessWidget {
  final Delivery delivery;

  const DeliveryPage({Key? key, required this.delivery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          delivery.title ?? delivery.code,
          style: theme.textTheme.titleLarge,
        ),
        backgroundColor: theme.colorScheme.background,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
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
                          "${event.data} ${event.hora}",
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
                        if (event.local != null)
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: theme.colorScheme.tertiary,
                              ),
                              Expanded(
                                child: Text(
                                  event.local ?? "",
                                  style: theme.textTheme.bodySmall,
                                ),
                              )
                            ],
                          ),
                        if (event.destino != null)
                          Row(
                            children: [
                              Icon(
                                Icons.local_shipping,
                                color: theme.colorScheme.tertiary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  event.destino ?? "",
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
}
