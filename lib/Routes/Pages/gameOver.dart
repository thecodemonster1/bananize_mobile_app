import 'package:flutter/material.dart';

class Gameover extends StatefulWidget {
  final int score;
  const Gameover({super.key, required this.score});

  @override
  State<Gameover> createState() => _GameoverState();
}

class _GameoverState extends State<Gameover> {
  
  @override
  void initState() {
    super.initState();
    // Perform your on-start action here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over'),
      ),
      body: Text("Game Over! Your final score: $widget.score"),
    );
  }
}
