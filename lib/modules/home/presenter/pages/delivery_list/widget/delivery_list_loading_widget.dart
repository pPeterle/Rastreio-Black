import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DeliveryListLoadingWidget extends StatelessWidget {
  const DeliveryListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      alignment: Alignment.topCenter,
      child: Lottie.asset(
        'assets/loading-delivery.json',
      ),
    );
  }
}
