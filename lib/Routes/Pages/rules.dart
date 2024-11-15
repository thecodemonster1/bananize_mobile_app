import 'package:bananize_mobile_app/Routes/Pages/home.dart';
import 'package:flutter/material.dart';

class MyRules extends StatelessWidget {
  const MyRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Space between content and button
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Welcome to the 🍌 Bananize Game! Here are the rules:\n\n",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // Bold style
                          fontSize:
                              22, // Slightly larger font size for emphasis
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            "1. Solve math problems from images to earn points.\n\n"
                            "2. Earn 10 points for each correct answer.\n\n"
                            "3. Activate Combo Mode by answering 3 questions in a row for 20 points per correct answer.\n\n"
                            "4. You have 20 seconds to solve each question; failing costs 1 life.\n\n"
                            "5. Start with 5 lives; the game ends when all lives are lost.\n\n"
                            "6. Reach 100 points to level up, reset lives, and unlock new challenges.\n\n"
                            "7. Pause and resume the timer at any time.\n\n"
                            "8. Aim for combos, climb levels, and achieve the highest score! 🎉\n\n"
                            "9. Incorrect answers reset your combo streak and cost 1 life.\n\n"
                            "10. Timer resets with each new question, so stay sharp!\n\n"
                            "11. Lives are replenished when you level up, giving you a fresh start.\n\n"
                            "12. Score higher by maintaining streaks and leveraging Combo Mode.\n\n"
                            "13. New levels introduce increasing difficulty to test your skills.\n\n"
                            "14. The game automatically moves to the next question after timeout.\n\n"
                            "15. Keep an eye on the timer and think fast to beat the clock!\n\n"
                            "16. Use the Pause button strategically to take a break and plan.\n\n"
                            "17. Challenge yourself to break your previous high score. 🎉\n\n"
                            "18. Remember, the ultimate goal is to have fun while sharpening your math skills! 🎯\n\n"
                            "Good luck!",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(16.0), // Add padding around the button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHome()),
                  );
                },
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
                child: const Text('Start Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
