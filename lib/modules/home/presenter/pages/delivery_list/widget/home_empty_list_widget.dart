import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeEmptyListWidget extends StatelessWidget {
  const HomeEmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Lottie.asset("assets/empty.json", height: 250),
          const SizedBox(
            height: 32,
          ),
          const Text(
            'Nenhuma encomenda a caminho',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
