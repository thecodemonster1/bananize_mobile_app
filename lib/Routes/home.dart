import 'package:bananize_mobile_app/Routes/heartIcon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHome> {
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
  int timerDuration = 20; // Timer duration in seconds
  int remainingTime = 20;
  Timer? _timer;

  // Track image loading
  bool isImageLoaded = false;
  bool isTimerRunning = false; // Track if the timer is running

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      message = '';
      isImageLoaded = false; // Reset image loaded state
    });

    final response =
        await http.get(Uri.parse('http://marcconrad.com/uob/banana/api.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        questionImageUrl = data['question'];
        solution = data['solution'];
        userInput = '';
        isLoading = false;
        remainingTime = timerDuration; // Reset timer for new question
      });
      startTimer();
    } else {
      throw Exception('Failed to load data');
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
      if (lives <= 0) {
        gameOver();
      } else {
        fetchData();
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

        if (comboCounter >= 3) {
          isComboActive = true;
          message += ' Combo activated! x2 points';
        }

        if (score >= level * 100) {
          levelUp();
        }
      });

      await Future.delayed(const Duration(seconds: 1));
      fetchData();
    } else {
      setState(() {
        lives--;
        comboCounter = 0;
        isComboActive = false;
        message = 'Wrong answer. Try again!';
        if (lives <= 0) {
          gameOver();
        } else {
          userInput = '';
        }
      });
    }
  }

  void levelUp() {
    setState(() {
      level++;
      lives = 5;
      isComboActive = false;
      comboCounter = 0;
      message = 'Level up! Welcome to level $level';
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(
                    top: 80, bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    // Display Score
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Score: $score',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
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
                      Image.network(
                        questionImageUrl!,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            // Image has fully loaded, set isImageLoaded to true
                            if (!isImageLoaded) {
                              setState(() {
                                isImageLoaded = true;
                              });
                              startTimer(); // Start the timer only when the image has loaded
                            }
                            return child;
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    const SizedBox(height: 20),
                    TextField(
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
                      controller: TextEditingController(text: userInput),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 12.0,
                              ),
                            ),
                            child: Text(isTimerRunning ? 'Pause' : 'Play')),
                        ElevatedButton(
                          onPressed: checkAnswer,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 12.0,
                            ),
                          ),
                          child: const Text('Submit'),
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
              ));
  }
}
