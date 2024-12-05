import 'package:audioplayers/audioplayers.dart';
import 'package:bananize_mobile_app/Routes/Pages/gameOver.dart';
import 'package:bananize_mobile_app/Routes/Widgets/globals.dart';
import 'package:bananize_mobile_app/Routes/Widgets/heartIcon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MyHome extends StatefulWidget {
  final Set<String?> email;
  const MyHome({super.key, required this.email});

  @override
  State<MyHome> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHome> {
  final TextEditingController _answerController = TextEditingController();
  String? questionImageUrl;
  int? solution;
  String userInput = '';
  bool isLoading = true;
  String message = '';
  int comboCounter = 0;
  int score = 0;
  int lives = 5;
  int level = 1;
  bool isComboActive = false;

  // Timer variables
  int timerDuration = 25; // Timer duration in seconds
  int remainingTime = 25;
  Timer? _timer;

  // Track image loading
  bool isImageLoaded = false;
  bool isTimerRunning = false; // Track if the timer is running

  @override
  void initState() {
    super.initState();
    fetchData();
    _uploadScoreToFirestore();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _uploadScoreToFirestore() async {
    final int finalScore = score <= 0 ? 0 : score;
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

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      message = '';
      isImageLoaded = false;
    });

    try {
      final response =
          await http.get(Uri.parse('http://marcconrad.com/uob/banana/api.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          questionImageUrl = data['question'];
          solution = data['solution'];
          userInput = '';
          isLoading = false;
          remainingTime = timerDuration;
          startTimer();
        });
      } else {
        setState(() {
          message = 'Failed to load data';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          handleTimeOut();
        }
      });
    });
    isTimerRunning = true;
  }

  void toggleTimer() {
    if (isTimerRunning) {
      // Pause the timer
      _timer?.cancel();
      setState(() {
        isTimerRunning = false;
      });
    } else {
      // Resume the timer
      startTimer();
    }
  }

  void handleTimeOut() {
    setState(() {
      lives--;
      comboCounter = 0;
      isComboActive = false;
      message = "Time's up! Moving to next question.";
      Future.delayed(const Duration(seconds: 1));
      if (lives <= 0) {
        // gameOver();
        endGame();
      } else {
        fetchData();
        // startTimer();
      }
    });
  }

  void checkAnswer() async {
    if (userInput.isEmpty) {
      setState(() {
        message = 'Please enter a number!';
      });
      return;
    }

    if (int.tryParse(userInput) == solution) {
      setState(() {
        score += isComboActive ? 20 : 10;
        message = 'Correct! 🎉';
        comboCounter++;
        debugPrint("score: $score");

        if (comboCounter >= 3) {
          isComboActive = true;
          message += ' Combo activated! x2 points';
          debugPrint("comboCounter: $comboCounter");
        }

        if (score >= level * 150) {
          levelUp();
        }
      });

      // await playCorrectAudio();
      await Future.delayed(const Duration(seconds: 1));
      fetchData();
    } else {
      setState(() {
        lives--;
        comboCounter = 0;
        isComboActive = false;
        message = 'Wrong answer. Try again!';
        if (lives <= 0) {
          // gameOver();
          endGame();
        }
      });

      // await playWrongAudio();
    }
  }

  void levelUp() {
    setState(() {
      level++;
      lives = 5;
      isComboActive = false;
      comboCounter = 0;
      message = 'Level up! Welcome to level $level';
      debugPrint("level: $level");
    });
  }

  void gameOver() {
    _timer?.cancel(); // Stop the timer
    setState(() {
      message = 'Game Over! Your final score: $score';
      score = 0;
      level = 1;
      comboCounter = 0;
      isComboActive = false;
      lives = 5;
    });
    fetchData();
  }

  void endGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Gameover(score: score, email: widget.email),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // body: isLoading
        //     ? const Center(child: CircularProgressIndicator())
        //     : SingleChildScrollView(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Globals.bgColor1, Globals.bgColor2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 80, bottom: 8, left: 8, right: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _uploadScoreToFirestore();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              backgroundColor:
                                  const Color.fromARGB(255, 150, 34, 34),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 12.0,
                              ),
                            ),
                            child: Icon(Icons.exit_to_app_rounded)),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Display Score
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'LEVEL: $level',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'SCORE: $score',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Timer and Lives Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time: $remainingTime',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Row(
                          children: List.generate(
                            lives,
                            (index) => const Hearticon(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (questionImageUrl != null)
                      isTimerRunning
                          ? Image.network(
                              // "http://marcconrad.com/uob/banana/api.php",
                              questionImageUrl!,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 200,
                              color: Colors.black.withOpacity(0.2),
                              alignment: Alignment.center,
                              child: const Text(
                                'Paused',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _answerController,
                      onChanged: (value) {
                        setState(() {
                          userInput = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your answer',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Play/Pause Button
                        OutlinedButton.icon(
                          onPressed: toggleTimer,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: const Color.fromARGB(179, 0, 0, 0)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 12.0,
                            ),
                          ),
                          // icon: const Icon(Icons.exit_to_app,
                          //     color: Color.fromARGB(179, 0, 0, 0), size: 28),
                          label: Text(
                            isTimerRunning ? '▐▐ ' : ' ▶ ',
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(179, 0, 0, 0)),
                          ),
                        ),

                        // Skip Button
                        OutlinedButton.icon(
                          onPressed: () {
                            if (score <= 0) {
                              endGame();
                              // score -= 5;
                              // return gameOver();
                            }
                            score -= 5;
                            fetchData();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: const Color.fromARGB(179, 0, 0, 0)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 12.0,
                            ),
                          ),
                          // icon: const Icon(Icons.exit_to_app,
                          //     color: Color.fromARGB(179, 0, 0, 0), size: 28),
                          label: const Text(
                            'Skip',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(179, 0, 0, 0)),
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   style: ElevatedButton.styleFrom(
                        //     foregroundColor: Colors.white,
                        //     backgroundColor: Colors.black,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(18.0),
                        //     ),
                        //     padding: const EdgeInsets.symmetric(
                        // horizontal: 32.0,
                        // vertical: 12.0,
                        //     ),
                        //   ),
                        //   child: const Text('Skip'),
                        // ),
                        // Answer Button
                        ElevatedButton(
                          onPressed: () {
                            checkAnswer();
                            // Clear the answer field
                            _answerController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor:
                                const Color.fromARGB(255, 217, 170, 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 12.0,
                            ),
                          ),
                          child: const Text(
                            'Answer',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
