import "package:flutter/material.dart";

class MySignup extends StatelessWidget {
  const MySignup({super.key});
  final int oneSideSize = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                padding: const EdgeInsets.all(1.0),
                // decoration: BoxDecoration(
                //   color: Colors.blueAccent,
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
                child: Image.asset(
                  'lib/Assets/banana-white.png',
                  width: oneSideSize.toDouble(),
                  height: oneSideSize.toDouble(),
                ),
              ),
              const SizedBox(height: 20),

              // Sign Up title
              const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Username TextField
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Email TextField
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Password TextField
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Sign Up button
              ElevatedButton(
                onPressed: () {}, // Add sign up functionality
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
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 10),

              // Already have an account link
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to login page
                },
                child: const Text('Already have an account? Click Here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
