import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/home/domain/entities/delivery.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeDeliveryCard extends StatelessWidget {
  final Delivery delivery;

  const HomeDeliveryCard({Key? key, required this.delivery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    "${delivery.events[0].data} ${delivery.events[0].hora}",
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
              Text(
                delivery.events[0].status,
                style: theme.textTheme.bodyMedium,
              ),
              if (delivery.events[0].local != null)
                Text(
                  delivery.events[0].local ?? "",
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
