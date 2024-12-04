import 'package:bananize_mobile_app/Routes/Pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bananize_mobile_app/Routes/Pages/scoreBoard.dart';
import 'package:bananize_mobile_app/Routes/Widgets/globals.dart';

class Gameover extends StatefulWidget {
  final int score;
  final Set<String?> email;

  const Gameover({super.key, required this.score, required this.email});

  @override
  State<Gameover> createState() => _GameoverState();
}

class _GameoverState extends State<Gameover> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _uploadScoreToFirestore();
  }

  Future<void> _uploadScoreToFirestore() async {
    final int finalScore = widget.score <= 0 ? 0 : widget.score;
    final String emailDisplay =
        widget.email.isNotEmpty ? widget.email.join(', ') : "Guest User";

    try {
      final docRef = _firestore.collection('scores').doc(emailDisplay);

      // Check if the document already exists
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final currentData = docSnapshot.data() as Map<String, dynamic>;

        // Update only if the new score is higher
        if (finalScore > (currentData['Score'] ?? 0)) {
          await docRef.update({
            'Score': finalScore,
            'UpdatedAt': FieldValue.serverTimestamp(),
          });
        }
      } else {
        // Create new document if not exists
        await docRef.set({
          'Name': emailDisplay,
          'Score': finalScore,
          'Rank':
              1, // You can update this later dynamically based on sorting logic.
          'CreatedAt': FieldValue.serverTimestamp(),
        });
      }

      debugPrint("Score uploaded successfully for $emailDisplay.");
    } catch (e) {
      debugPrint("Error uploading score: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final int finalScore = widget.score <= 0 ? 0 : widget.score;
    final String emailDisplay =
        widget.email.isNotEmpty ? widget.email.join(', ') : "Guest User";

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Globals.bgColor1, Globals.bgColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hello, $emailDisplay',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
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
            const Text(
              'Your Final Score',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              '$finalScore',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 12.0),
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
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Scoreboard()),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color.fromARGB(179, 0, 0, 0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              // icon: const Icon(
              //   Icons.exit_to_app,
              //   color: Color.fromARGB(179, 0, 0, 0),
              //   size: 28,
              // ),
              label: const Text(
                'Scoreboard',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(179, 0, 0, 0)),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyLogin()),
                  (Route<dynamic> route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color.fromARGB(179, 0, 0, 0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              icon: const Icon(
                Icons.exit_to_app,
                color: Color.fromARGB(179, 0, 0, 0),
                size: 20,
              ),
              label: const Text(
                'Log Out',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(179, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
