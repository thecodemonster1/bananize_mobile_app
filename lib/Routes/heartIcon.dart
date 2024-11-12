import 'package:flutter/material.dart';

class Hearticon extends StatelessWidget {
  const Hearticon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite,
      color: Colors.red,
      size: 24.0, // Adjust size as needed
    );
  }
}
