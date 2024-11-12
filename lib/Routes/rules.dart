import 'package:bananize_mobile_app/Routes/home.dart';
import 'package:flutter/material.dart';

class MyRules extends StatelessWidget {
  const MyRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHome()),
            );
          }, // Add sign in functionality
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black, // Text color (white)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0, // Horizontal padding
              vertical: 12.0, // Vertical padding
            ),
          ),
          child: const Text('Start Game'),
        ),
      ),
    );
  }
}
