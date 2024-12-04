import 'package:bananize_mobile_app/Routes/Pages/home.dart';
import 'package:bananize_mobile_app/Routes/Pages/scoreBoard.dart';
import 'package:bananize_mobile_app/Routes/Widgets/globals.dart';
import 'package:flutter/material.dart';

class MyRules extends StatelessWidget {
  final Set<String?> email;
  const MyRules({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Globals.bgColor1,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // padding: const EdgeInsets.only(top: 60),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Globals.bgColor1, Globals.bgColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
                            "Welcome to the 🍌 Bananize Game! Here are the 18 rules:\n\n",
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
                            "3. Activate Combo Mode by answering 3 questions consecutively for 20 points per correct answer.\n\n"
                            "4. You have 25 seconds to solve each question; failing to answer costs 1 life.\n\n"
                            "5. Start with 5 lives; the game ends when all lives are lost.\n\n"
                            "6. Reach 100 points to level up, reset lives, and unlock new challenges.\n\n"
                            "7. Pause and resume the timer anytime for strategic breaks.\n\n"
                            "8. Maximize your score by maintaining streaks and leveraging Combo Mode.\n\n"
                            "9. Incorrect answers reset your combo streak and cost 1 life.\n\n"
                            "10. The timer resets with each new question, so stay sharp!\n\n"
                            "11. Lives are replenished upon leveling up, offering a fresh start.\n\n"
                            "12. Difficulty increases with each new level to test your skills.\n\n"
                            "13. The game automatically advances to the next question after timeout.\n\n"
                            "14. Manage the timer wisely and think quickly to beat the clock!\n\n"
                            "15. Use the Skip button strategically to move on but lose 5 points.\n\n"
                            "16. Push your limits to break your previous high score. 🎯\n\n"
                            "17. Enjoy the game and sharpen your math skills along the way! 🎉\n\n"
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scoreboard()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side:
                          BorderSide(color: const Color.fromARGB(179, 0, 0, 0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                    ),
                    // icon: const Icon(Icons.exit_to_app,
                    //     color: Color.fromARGB(179, 0, 0, 0), size: 28),
                    label: const Text(
                      'Scoreboard',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(179, 0, 0, 0)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHome(email: email)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: const Color.fromARGB(255, 167, 167, 167),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                    ),
                    child: const Text(
                      'Start Game',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
