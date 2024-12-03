import 'package:flutter/material.dart';

class Gameover extends StatefulWidget {
  final int score;
  final Set<String?> email;
  const Gameover({super.key, required this.score, required this.email});

  @override
  State<Gameover> createState() => _GameoverState();
}

class _GameoverState extends State<Gameover> {
  @override
  void initState() {
    super.initState();
    // Perform your on-start action here
    debugPrint("${widget.email}!! \nfinal score: ${widget.score}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over'),
        backgroundColor: Colors.amber[200],
      ),
      body: Center(
          child: Text(
              "Game Over!\nYour final score: ${widget.score <= 0 ? 0 : widget.score}")),
    );
  }
}

