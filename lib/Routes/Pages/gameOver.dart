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
    debugPrint("User Email: ${widget.email} \nFinal Score: ${widget.score}");
  }

  @override
  Widget build(BuildContext context) {
    final int finalScore = widget.score <= 0 ? 0 : widget.score;
    final String emailDisplay =
        widget.email.isNotEmpty ? widget.email.join(', ') : "Guest User";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over',
            style: TextStyle(color: Color.fromARGB(227, 15, 15, 15))),
        backgroundColor: const Color.fromARGB(255, 232, 211, 21),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 232, 211, 21),
              Color.fromARGB(255, 107, 64, 0)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Displaying user's email
            Text(
              'Hello, $emailDisplay',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Game Over text
            Text(
              'Game Over!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 88, 85, 54),
                shadows: [
                  Shadow(
                    offset: const Offset(2, 2),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Score Display
            Text(
              'Your Final Score',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            Text(
              '$finalScore',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 60),

            // Action buttons
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              icon: const Icon(
                Icons.restart_alt,
                size: 28,
                color: Color.fromARGB(182, 255, 255, 255),
              ),
              label: const Text(
                'Play Again',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // OutlinedButton.icon(
            //   onPressed: () {},
            //   style: OutlinedButton.styleFrom(
            //     side: BorderSide(color: Colors.white70),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //   ),
            //   icon: const Icon(Icons.exit_to_app,
            //       color: Colors.white70, size: 28),
            //   label: const Text(
            //     'Exit',
            //     style: TextStyle(fontSize: 20, color: Colors.white70),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
