import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class HomeDeliveryCard extends StatelessWidget {
  final Delivery delivery;

  const HomeDeliveryCard({Key? key, required this.delivery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("dd/MM/yyyy HH:mm");
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: InkWell(
        onTap: () {
          Modular.to.pushNamed('/delivery', arguments: delivery);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    delivery.title.isEmpty ? delivery.code : delivery.title,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    dateFormat.format(delivery.events[0].data),
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
              Text(
                delivery.events[0].status,
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                "${delivery.events[0].unity.name} - ${delivery.events[0].unity.city} / ${delivery.events[0].unity.uf}",
                style: theme.textTheme.bodySmall,
              ),
              Text(
                delivery.code,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
